local M = {}

local SOCK = vim.fn.expand("~/.cache/nvim/nvim-dap.sock")

local function toggle_agent_socket()
  for _, addr in ipairs(vim.fn.serverlist()) do
    if addr == SOCK then
      vim.fn.serverstop(addr)
      vim.notify("[dap_agent] Socket closed", vim.log.levels.INFO)
      return
    end
  end
  vim.fn.serverstart(SOCK)
  vim.notify("[dap_agent] Socket open → " .. SOCK, vim.log.levels.INFO)
end

function M.setup()
  local dap = require("dap")
  local widgets = require("dap.ui.widgets")
  local agent = require("agent.dap_agent")

  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Attach / continue" })
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
  vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
  vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
  vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
  vim.keymap.set("n", "<leader>dh", widgets.hover, { desc = "DAP hover" })
  vim.keymap.set("n", "<leader>ds", function()
    widgets.centered_float(widgets.scopes)
    agent.dump_context()
  end, { desc = "DAP scopes (+ dump context)" })
  vim.keymap.set("n", "<leader>df", function()
    widgets.centered_float(widgets.frames)
  end, { desc = "DAP frames" })
  vim.keymap.set("n", "<leader>da", toggle_agent_socket, { desc = "Toggle DAP agent socket" })
end

return M
