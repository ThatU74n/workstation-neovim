---@type LazySpec
return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
        },
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        float = {
          transparent = false,
          solid = false,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
      })
    end,
  },
}
