-- setkeymapping for dap
local opt = { silent = true, noremap = true }
local set_keymap = vim.api.nvim_set_keymap

set_keymap("n", "<F9>", [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], opt)
set_keymap("n", "<F5>", [[<cmd>lua require'dap'.continue()<CR>]], opt)
set_keymap("n", "<F10>", [[<cmd>lua require'dap'.step_over()<CR>]], opt)
set_keymap("n", "<F11>", [[<cmd>lua require'dap'.step_into()<CR>]], opt)
-- F23 measn Shift + F11
set_keymap("n", "<F23>", [[<cmd>lua require'dap'.step_out()<CR>]], opt)
