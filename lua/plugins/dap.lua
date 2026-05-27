--- @type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local gitsigns_ok, gitsigns = pcall(require, "gitsigns")


      vim.fn.sign_define("DapBreakPoint", {
        text = "󰐾 ",
        texthl = "DapBreakPoint",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapStopped", {
        text = "▶",
        texthl = "DapStopped",
        linehl = "DapStopped",
        numhl = ""
      })

      --- Java debug adapter
      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Attach to JVM (25005)",
          hostName = "localhost",
          port = 25005,
        }
      }

      if not gitsigns_ok then
        return
      end

      dap.listeners.after.event_initialized["gitsigns_blame"] = function()
        gitsigns.toggle_current_line_blame(false)
      end
      dap.listeners.before.event_terminated["gitsigns_blame"] = function()
        gitsigns.toggle_current_line_blame(true)
      end
      dap.listeners.before.event_exited["gitsigns_blame"] = function()
        gitsigns.toggle_current_line_blame(true)
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
