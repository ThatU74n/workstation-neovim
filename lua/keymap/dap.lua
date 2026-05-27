local M = {}

function M.setup()
  local dap = require("dap")
  local widgets = require("dap.ui.widgets")

  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Attach / continue" })
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
  vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
  vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
  vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
  vim.keymap.set("n", "<leader>dh", widgets.hover, { desc = "DAP hover" })
  vim.keymap.set("n", "<leader>ds", function() widgets.centered_float(widgets.scopes) end, { desc = "DAP scopes" })
  vim.keymap.set("n", "<leader>df", function() widgets.centered_float(widgets.frames) end, { desc = "DAP frames" })
end

return M
