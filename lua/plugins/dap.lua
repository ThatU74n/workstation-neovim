--- @type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ffcc00", bg = "#3d3000" })

      vim.fn.sign_define("DapBreakpoint", {
        text = "󰐾 ",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapStopped", {
        text = "▶",
        texthl = "DapStopped",
        linehl = "DapStopped",
        numhl = ""
      })


      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Attach to JVM (25005)",
          hostName = "localhost",
          port = 25005,
        }
      }
    end,
  },
}
