command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'option': '--reverse'}, <bang>0))

command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=auto '.shellescape(<q-args>), 0,
\   fzf#vim#with_preview({'option': '--exact --reverse --delimiter : --nth 3 ..'},
\   'right:50%:wrap'))

nnoremap <Leader>ff :Files 
nnoremap <Leader>fr :Rg 
