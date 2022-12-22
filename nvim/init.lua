require("impatient")
local api = vim.api
local cmd = vim.cmd
local set_keymap = api.nvim_set_keymap
local o, wo, bo = vim.o, vim.wo, vim.bo

vim.g.mapleader = " "
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0

--o.title = true
o.updatetime = 250
wo.signcolumn = "yes"
wo.number = true
wo.relativenumber = true
-- indent
bo.autoindent = true
bo.smartindent = true
bo.expandtab = true
o.expandtab = true
bo.tabstop = 2
bo.softtabstop = -1
bo.shiftwidth = 0

-- search

o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.smartcase = true
o.wrapscan = true
--
o.swapfile = false
o.showcmd = true
o.hidden = true
o.swapfile = false
o.autoread = true
o.splitright = true
o.autoread = true
o.wildmenu = true
o.showmatch = true

-- color scheme
o.termguicolors = true
o.background = "dark"
cmd("colorscheme tokyonight")

-- clipboard
vim.opt.clipboard:append({ "unnamedplus" })

-- keymap
set_keymap("n", "j", "gj", { noremap = true })
set_keymap("n", "k", "gk", { noremap = true })
set_keymap("v", "j", "gj", { noremap = true })
set_keymap("v", "k", "gk", { noremap = true })

vim.keymap.set("t", "<C-p>", "<Up>")

set_keymap("n", "<C-h>", "<C-w>h", { noremap = true })
set_keymap("n", "<C-j>", "<C-w>j", { noremap = true })
set_keymap("n", "<C-k>", "<C-w>k", { noremap = true })
set_keymap("n", "<C-l>", "<C-w>l", { noremap = true })

set_keymap("n", "<C-Down>", "<cmd>bnext<CR>", { noremap = true, silent = false })
set_keymap("n", "<C-Up>", "<cmd>bNext<CR>", { noremap = true, silent = false })

cmd("syntax on")

-- Commands
cmd([[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]])
cmd([[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]])
cmd([[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]])
cmd([[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]])
cmd([[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]])

cmd("filetype plugin indent on")
