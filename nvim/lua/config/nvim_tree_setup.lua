local silent = { silent = true }
local set_keymap = vim.api.nvim_set_keymap

set_keymap("n", "<Leader>tt", [[<cmd>NvimTreeToggle<cr>]], silent)
set_keymap("n", "<Leader>tr", [[<cmd>NvimTreeRefresh<cr>]], silent)
set_keymap("n", "<Leader>tf", [[<cmd>NvimTreeFindFile<cr>]], silent)
