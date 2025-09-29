vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_python_provider = 0

vim.g.loaded_python3_provider = 0
vim.loader.enable()

require("lazyvim")

local opt = vim.opt
opt.updatetime = 250
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true

-- indent
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 0
opt.softtabstop = -1
opt.autoindent = true
opt.smartindent = true

-- search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

opt.swapfile = false
opt.undofile = true
opt.hidden = true
opt.autoread = true
opt.splitright = true
opt.wildmenu = true
opt.showmatch = true

opt.termguicolors = true
opt.background = "dark"

opt.clipboard:append("unnamedplus")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map({"n","v"}, "j", "gj", opts)
map({"n","v"}, "k", "gk", opts)
map("t", "<C-p>", "<Up>", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-Down>", "<cmd>bnext<CR>", opts)
map("n", "<C-Up>",   "<cmd>bprevious<CR>", opts)
