-- setkeymapping for dap
local silent = { silent = true }
local set_keymap = vim.api.nvim_set_keymap

set_keymap("n", "<Leader>d", [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], silent)
