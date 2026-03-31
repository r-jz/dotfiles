vim.loader.enable()
vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

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

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    vim.treesitter.start()
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
  end,
})

local function readfile(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local s = f:read("*a")
  f:close()
  return s
end

local function proc_comm_and_ppid(pid)
  local stat = readfile("/proc/" .. pid .. "/stat")
  if not stat then
    return nil, nil
  end

  -- /proc/<pid>/stat:
  -- pid (comm) state ppid ...
  local comm, ppid = stat:match("^%d+ %((.-)%) . (%d+)")
  return comm, ppid
end


local function gui_clipboard_provider()
  if vim.env.WAYLAND_DISPLAY and vim.fn.executable("waycopy") == 1 and vim.fn.executable("waypaste") == 1 then
    return "wayclip"
  elseif vim.env.WAYLAND_DISPLAY and vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1 then
    return "wl-copy"
  elseif vim.env.DISPLAY and vim.fn.executable("xclip") == 1 then
    return "xclip"
  elseif vim.env.DISPLAY and vim.fn.executable("xsel") == 1 then
    return "xsel"
  else
    return nil
  end
end

local function is_tmux_client_over_ssh()
  if not vim.env.TMUX or vim.env.TMUX == "" then
    return false
  end
  local pid = vim.fn.system("tmux display-message -p '#{client_pid}'"):gsub("%s+", "")
  if pid == "" then
    return false
  end

  while pid ~= "" and pid ~= "1" do
    local comm, ppid = proc_comm_and_ppid(pid)
    if not comm then
      return false
    end
    if comm == "sshd" then
      return true
    end
    pid = ppid or ""
  end

  return false
end

local function set_clipboard()
  if is_tmux_client_over_ssh() then
    vim.g.clipboard = "osc52"
  else
    vim.g.clipboard = gui_clipboard_provider() or "osc52"
  end
end

vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
  callback = set_clipboard,
})

set_clipboard()

opt.clipboard:append("unnamedplus")

require("lazyvim")

