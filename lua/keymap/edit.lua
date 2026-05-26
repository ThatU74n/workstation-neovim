-- Indent
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection", silent = true, noremap = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection", silent = true, noremap = true })


-- Wrap text in parens, brackets, quotes, etc. in visual mode 
vim.keymap.set('v', '<leader>', 'c\'<C-r>"\'', { desc = "Wrap selection in double quotes", silent = true, noremap = true })
vim.keymap.set('v', '<leader>"', 'c"<C-r>"\"', { desc = "Wrap selection in single quotes", silent = true, noremap = true })
vim.keymap.set('v', '<leader>`', 'c`<C-r>"`', { desc = "", silent = true, noremap = true })
vim.keymap.set('v', '<leader>(', 'c(<C-r>")', { desc = "", silent = true, noremap = true })
vim.keymap.set('v', '<leader>[', 'c[<C-r>"]', { desc = "", silent = true, noremap = true })
vim.keymap.set('v', '<leader>{', 'c{<C-r>"}', { desc = "", silent = true, noremap = true })
