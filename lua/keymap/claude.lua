vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<CR>", { desc = "Claude Code", silent = true, noremap = true })
vim.keymap.set({"n", "v"}, "<leader>af", "<cmd>ClaudeFocus<CR>", { desc = "Claude Focus", silent = true, noremap = true })
vim.keymap.set("n", "<leader>al", "<cmd>ClaudeCodeToggleLayout<CR>", { desc = "Claude Code Toggle Layout", silent = true, noremap = true })
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>", { desc = "Claude Code Add Buffer", silent = true, noremap = true })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeAddSelection<CR>", { desc = "Claude Code Add Selection", silent = true, noremap = true })

vim.keymap.set("t", "<leader>a<Left>", "<C-\\><C-n><C-w>h", { desc = "Jump out", silent = true, noremap = true })
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>", { desc = "Claude Code Diff Accept", silent = true, noremap = true })
vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffReject<CR>", { desc = "Claude Code Diff Reject", silent = true, noremap = true })

local explorer_fts = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" }
vim.api.nvim_create_autocmd("FileType", {
  pattern = explorer_fts,
  callback = function()
    vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<CR>", { desc = "Claude Code Tree Add", silent = true, noremap = true })
  end,
})
