set hidden
set hidden

let g:LanguageClient_serverCommands = {}

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'c': ['ccls'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls']
    \ }

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END

let g:LanguageClient_autoStart = 1
let g:LanguageClient_useFloatingHover = 1
nnoremap <Leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <Leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <Leader>lv :call LanguageClient_textDocument_definition({'gotoCmd': 'vsplit'})<CR>
nnoremap <Leader>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <Leader>lf :call LanguageClient_textDocument_formatting()<CR>

