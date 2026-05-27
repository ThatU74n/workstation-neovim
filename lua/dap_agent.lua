local M = {}

local CONTEXT_PATH = vim.fn.expand("~/.cache/nvim/dap_context.json")
local EVAL_PATH = vim.fn.expand("~/.cache/nvim/dap_eval.json")

local function session()
  local s = require("dap").session()
  if not s then
    vim.notify("[dap_agent] No active DAP session", vim.log.levels.WARN)
  end
  return s
end

local function write_json(path, data)
  vim.fn.writefile({ vim.fn.json_encode(data) }, path)
end

function M.continue()   require("dap").continue() end
function M.terminate()  require("dap").terminate() end
function M.step_over()  require("dap").step_over() end
function M.step_into()  require("dap").step_into() end
function M.step_out()   require("dap").step_out() end

function M.set_breakpoint(file, line)
  local bufnr = vim.fn.bufadd(file)
  vim.fn.bufload(bufnr)
  require("dap.breakpoints").set({}, bufnr, line)
  vim.notify(string.format("[dap_agent] Breakpoint set: %s:%d", file, line), vim.log.levels.INFO)
end

function M.clear_breakpoints()
  require("dap").clear_breakpoints()
  vim.notify("[dap_agent] All breakpoints cleared", vim.log.levels.INFO)
end

function M.dump_context()
  local s = session()
  if not s then return end

  local frame = s.current_frame
  if not frame then
    vim.notify("[dap_agent] No current frame", vim.log.levels.WARN)
    return
  end

  s:request("scopes", { frameId = frame.id }, function(err, res)
    if err or not res then return end

    local scopes_data = { frame = { name = frame.name, line = frame.line, source = frame.source and frame.source.path }, scopes = {} }
    local pending = #res.scopes

    if pending == 0 then
      write_json(CONTEXT_PATH, scopes_data)
      return
    end

    for _, scope in ipairs(res.scopes) do
      s:request("variables", { variablesReference = scope.variablesReference }, function(err2, vars_res)
        if not err2 and vars_res then
          table.insert(scopes_data.scopes, { scope = scope.name, variables = vars_res.variables })
        end
        pending = pending - 1
        if pending == 0 then
          write_json(CONTEXT_PATH, scopes_data)
          vim.notify("[dap_agent] Context dumped → " .. CONTEXT_PATH, vim.log.levels.INFO)
        end
      end)
    end
  end)
end

function M.eval(expr)
  local s = session()
  if not s then return end

  local frame = s.current_frame
  if not frame then
    vim.notify("[dap_agent] No current frame", vim.log.levels.WARN)
    return
  end

  s:request("evaluate", { expression = expr, frameId = frame.id, context = "repl" }, function(err, res)
    if err then
      write_json(EVAL_PATH, { expression = expr, error = tostring(err) })
    else
      write_json(EVAL_PATH, { expression = expr, result = res.result, type = res.type })
    end
    vim.notify("[dap_agent] Eval result → " .. EVAL_PATH, vim.log.levels.INFO)
  end)
end

return M
