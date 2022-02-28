local silent = { silent = true }
local set_keymap = vim.api.nvim_set_keymap
-- Navigate buffers and repos
set_keymap("n", "<Leader>fb", [[<cmd>Telescope buffers show_all_buffers=true<cr>]], silent)
set_keymap("n", "<Leader>fg", [[<cmd>Telescope git_files<cr>]], silent)
set_keymap("n", "<Leader>ff", [[<cmd>Telescope find_files<cr>]], silent)
set_keymap("n", "<Leader>fr", [[<cmd>Telescope live_grep<cr>]], silent)

-- lsp actions
set_keymap("n", "<Leader>flr", [[<cmd>Telescope lsp_references<cr>]], silent)
set_keymap("n", "<Leader>fld", [[<cmd>Telescope lsp_definitions<cr>]], silent)
