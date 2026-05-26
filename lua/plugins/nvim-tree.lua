---@type LazySpec
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
        },
        sections = {
          lualine_a = {
             {
              "filename",
              path = 1,
            }
          },
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {},
          lualine_z = {"location"},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
             {
              "filename",
              path = 1,
            }
          },
          lualine_x = {"location"},
          lualine_y = {},
          lualine_z = {}
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
      })
    end,
  },
}
