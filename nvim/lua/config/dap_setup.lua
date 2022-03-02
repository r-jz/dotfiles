-- setkeymapping for dap
local opt = { silent = true, noremap = true }
local set_keymap = vim.api.nvim_set_keymap

set_keymap("n", "<Leader>dd", [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], opt)
set_keymap("n", "<Leader>dc", [[<cmd>lua require'dap'.continue()<CR>]], opt)
