--- @type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

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
    end,
  },
}
