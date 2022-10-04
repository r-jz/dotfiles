local silent = { silent = true }

vim.keymap.set("n", "<Leader>tt", [[<cmd>NvimTreeToggle<cr>]], silent)
vim.keymap.set("n", "<Leader>tr", [[<cmd>NvimTreeRefresh<cr>]], silent)
vim.keymap.set("n", "<Leader>tf", [[<cmd>NvimTreeFindFile<cr>]], silent)
