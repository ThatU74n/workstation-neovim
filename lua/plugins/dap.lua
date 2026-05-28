--- @type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local icon = require("config.theme")

      vim.fn.sign_define("DapBreakpoint", icon.dap_breakpoint)
      vim.fn.sign_define("DapStopped", icon.dap_stopped)

      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Attach to JVM (25005)",
          hostName = "localhost",
          port = 25005,
        },
      }
    end,
  },
}
