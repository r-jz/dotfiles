local opts = { noremap = true, silent = true }
function _G.set_terminal_keymaps()
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm <cr>", opts)
vim.keymap.set("n", "<C-t><C-f>", "<cmd>ToggleTerm direction=float<cr>", opts)
vim.keymap.set("n", "<C-t><C-h>", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", opts)
vim.keymap.set("n", "<C-t><C-v>", "<cmd>ToggleTerm size=80 direction=vertical<cr>", opts)
vim.keymap.set("n", "<C-t><C-t>", "<cmd>ToggleTerm size=80 direction=tab<cr>", opts)
