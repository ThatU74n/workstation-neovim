local builtin = require("telescope.builtin")
vim.keymap.set("n", "lg", builtin.live_grep, { desc = "Find files", silent = true, noremap = true })
