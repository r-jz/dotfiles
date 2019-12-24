let s:base_dir = expand('~/.config/nvim')

execute 'set runtimepath+=' . fnamemodify(s:base_dir, 'p')

runtime! basic.vim
runtime! dein.vim
