--- @type LazySpec
return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        yaml = { "trim_whitespace" },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
