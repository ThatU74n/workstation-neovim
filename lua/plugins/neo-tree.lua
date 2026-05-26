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
            },
          },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = {},
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.api.nvim_set_hl(0, "NeoTreeAnsible", { fg = "#FFFFFF" })
      vim.api.nvim_set_hl(0, "NeoTreeGitHub",  { fg = "#181717" })
      vim.api.nvim_set_hl(0, "NeoTreeGitea",   { fg = "#609926" })
      vim.api.nvim_set_hl(0, "NeoTreeHelm",    { fg = "#3A46E8" })
      vim.api.nvim_set_hl(0, "NeoTreeTerraform", { fg = "#7B42BC" })
      vim.api.nvim_set_hl(0, "NeoTreeK8s",     { fg = "#326CE5" })

      local icons = {
        github          = { icon = " ", hl = "NeoTreeGitHub" },          -- nf-dev-github
        gitea           = { icon = " ", hl = "NeoTreeGitea" },           -- nf-dev-gitea
        github_actions  = { icon = " ", hl = "NeoTreeGitHub" },          -- nf-dev-github_actions
        test            = { icon = " ", hl = "NeoTreeGitHub" },          -- nf-dev-test_tube
        doc             = { icon = "󱔘 ", hl = "NeoTreeGitHub" },          -- nf-dev-document
        k8s             = { icon = " ", hl = "NeoTreeK8sIcon" },         -- nf-dev-kubernetes 
        ansible         = { icon = " ", hl = "NeoTreeAnsible" },         -- nf-dev-ansible 
        terraform       = { icon = " ", hl = "NeoTreeTerraform" },       -- nf-dev-terraform
        helm            = { icon = " ", hl = "NeoTreeHelm" },            -- nf-dev-helm 
      }

      local path_cache = {}

      local function detect_project_type(path, name)
        if path_cache[path] ~= nil then return path_cache[path] end
        local type
        if name == ".github" then
          type = "github"
        elseif name == ".gitea" then
          type = "gitea"
        elseif name == "docs" or name == "doc" then
          type = "doc" 
        elseif name == "tests" or name == "test" then 
          type = "test"
        elseif name == "k8s" or name == "kubernetes" then
          type = "k8s"
        elseif vim.fn.filereadable(path .. "/ansible.cfg") == 1 then
          type = "ansible"
        elseif vim.fn.filereadable(path .. "/main.tf") == 1 then 
          type = "terraform"
        elseif vim.fn.filereadable(path .. "/Chart.yaml") == 1
            or vim.fn.filereadable(path .. "/values.yaml") == 1 then
          type = "helm"
        end

        path_cache[path] = type or false
        return type
      end

      local function render_directory(type)
        local p = type and icons[type]
        if p then
          return { text = p.icon .. " ", highlight = p.hl }
        end
      end

      local function render_file(path)
        local parent      = vim.fn.fnamemodify(path, ":h:t")
        local grandparent = vim.fn.fnamemodify(path, ":h:h:t")
        if parent == "workflows" and (grandparent == ".github" or grandparent == ".gitea") then
          return { text = icons.github_actions.icon .. " ", highlight = icons.github_actions.hl }
        end
      end

      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          width = 30,
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          hijack_netrw_behavior = "open_current",
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
          components = {
            icon = function(config, node, state)
              local result 
              if node.type == "directory" then 
                local type = detect_project_type(node.path, node.name)
                result = render_directory(type)
              elseif node.type == "file" then 
                result = render_file(node.path)
              end 

              return result or require("neo-tree.sources.filesystem.components").icon(config, node, state)
            end
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added     = "",
              modified  = "",
              deleted   = "✖",
              renamed   = "󰁕",
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            },
          },
        },
      })
    end,
  },
}
