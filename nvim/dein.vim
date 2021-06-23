set nocompatible

set encoding=utf-8
scriptencoding utf-8

filetype plugin indent off
syntax off

let s:base_dir = expand('~/.config/nvim')
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml_dir = s:base_dir . '/toml'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Required:
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#load_toml(s:toml_dir . '/general.toml',     {'lazy':0})
    call dein#load_toml(s:toml_dir . '/lazy.toml',        {'lazy':1})
    call dein#end()
    call dein#save_state()
endif

" If there are the plugins that has not been installed on startup,
" dein is checking and installing.

if dein#check_install()
    call dein#install()
endif

" Required:
filetype plugin indent on

syntax on
