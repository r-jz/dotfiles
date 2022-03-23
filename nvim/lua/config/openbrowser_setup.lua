vim.g.netrw_nogx = 1
local silent = { silent = true }
vim.api.nvim_set_keymap("n", "gx", "<Plug>(openbrowser-smart-search)", silent)
vim.api.nvim_set_keymap("v", "gx", "<Plug>(openbrowser-smart-search)", silent)
