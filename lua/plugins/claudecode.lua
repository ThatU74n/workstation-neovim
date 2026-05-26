---@type LazySpec
return {
  {
    "coder/claudecode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      local claudecode = require("claudecode") 
      local toggle_key = "<C-,>" 
      local hide_key = {
        claude_hide = {
          toggle_key,
          function ()
            self:hide()
          end,
          mode = "t",
          desc = "Hide",
        },
      }

      local modes = {
        float = {
          position = "float",
          width = 0.9,
          height = 0.9,
          backdrop = 60,
          keys = hide_key,
        },
        right = {
          position = "right",
          width = 0.4,
          keys = hide_key,
        },
      }

      local current_mode = "right" 

      local function apply_mode(mode)
        current_mode = mode
        claudecode.setup({
          terminal_cmd = "/opt/homebrew/bin/claude",
          terminal = { snacks_win_opts = modes[mode] },
        })
      end

      vim.api.nvim_create_user_command("ClaudeCodeToggleLayout", function()
        local next_mode = current_mode == "float" and "right" or "float"
        apply_mode(next_mode)
        vim.notify("Claude layout: " .. next_mode, vim.log.levels.INFO)

        -- If Claude terminal is currently open, close and reopen to apply the new layout
        local is_open = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "claude" then
            is_open = true
            break
          end
        end

        if is_open then
          vim.cmd("ClaudeCode") -- close
          vim.cmd("ClaudeCode") -- reopen with new layout
        end
      end, { desc = "Toggle Claude layout between float and right split" })
    end,
  },
  {
    "github/copilot.vim",

  }
}
