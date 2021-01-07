let s:base_dir = expand('~/.config/nvim')

execute 'set runtimepath+=' . fnamemodify(s:base_dir, 'p')

let g:python3_host_prog = expand('$HOME/.venv/neovim/bin/python3')
runtime! basic.vim
runtime! dein.vim
