-- setkeymapping for dap
local opt = { silent = true, noremap = true }

vim.keymap.set("n", "<F9>", [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], opt)
vim.keymap.set("n", "<F5>", [[<cmd>lua require'dap'.continue()<CR>]], opt)
vim.keymap.set("n", "<F10>", [[<cmd>lua require'dap'.step_over()<CR>]], opt)
vim.keymap.set("n", "<F11>", [[<cmd>lua require'dap'.step_into()<CR>]], opt)
-- F23 measn Shift + F11
vim.keymap.set("n", "<F23>", [[<cmd>lua require'dap'.step_out()<CR>]], opt)
