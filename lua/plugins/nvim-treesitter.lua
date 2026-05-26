---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "go",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "nginx",
      "python",
      "terraform",
      "typescript",
      "tsx",
      "yaml",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
