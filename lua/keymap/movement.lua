--- Cursor movement 
vim.keymap.set(
  {"n", "v"},
  "<S-Up>",
  "4k",
  { desc = "Move cursor up 4 lines", silent = true, noremap = true }
)
vim.keymap.set({"n", "v"}, "<S-Down>", "4j", { desc = "Move cursor down 4 lines", silent = true, noremap = true })
vim.keymap.set({"n", "v"}, "<S-Left>", "b", { desc = "Move cursor to previous character", silent = true, noremap = true })
vim.keymap.set({"n", "v"}, "<S-Right>", "w", { desc = "Move cursor to next character", silent = true, noremap = true })

--- Tab movement 
vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1", silent = true, noremap = true })
vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2", silent = true, noremap = true })
vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3", silent = true, noremap = true })
vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4", silent = true, noremap = true })
vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5", silent = true, noremap = true })
vim.keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6", silent = true, noremap = true })
vim.keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7", silent = true, noremap = true })
vim.keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8", silent = true, noremap = true })
vim.keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9", silent = true, noremap = true })
vim.keymap.set("n", "<leader>0", ":BufferLineGoToBuffer 10<CR>", { desc = "Go to buffer 10", silent = true, noremap = true })
vim.keymap.set("n", "<leader><Left>", ":BufferLineCyclePrev<CR>", { desc = "Go to previous buffer", silent = true, noremap = true })
vim.keymap.set("n", "<leader><Right>", ":BufferLineCycleNext<CR>", { desc = "Go to next buffer", silent = true, noremap = true })
vim.keymap.set("n", "<leader><Tab>d", ":bdelete<CR>", { desc = "Close current buffer", silent = true, noremap = true })


--- Window movement 
vim.keymap.set("n", "<leader>w<Up>", "<C-w>k", { desc = "Move to window above", silent = true, noremap = true })
vim.keymap.set("n", "<leader>w<Down>", "<C-w>j", { desc = "Move to window below", silent = true, noremap = true })
vim.keymap.set("n", "<leader>w<Left>", "<C-w>h", { desc = "Move to window left", silent = true, noremap = true })
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l", { desc = "Move to window right", silent = true, noremap = true })
