let g:neoterm_default_mod="belowright"
let g:neoterm_size=10
let g:neoterm_autoscroll=1
let g:neoterm_autoinsert=1

function! NTermVerticalSplit()
  let l:tmp_mod = g:neoterm_default_mod
  let l:tmp_size = g:neoterm_size
  let g:neoterm_default_mod = "vertical"
  let g:neoterm_size = ''
  Tnew
  let g:neoterm_default_mod = tmp_mod
  let g:neoterm_size = tmp_size
endfunction

function! NTermMulti(h_num, v_num)
  let l:tmp_mod = g:neoterm_default_mod
  let l:tmp_size = g:neoterm_size
  let g:neoterm_default_mod ="tab"
  let g:neoterm_size = ''
  Tnew
  "# vertical split
  let g:neoterm_default_mod = "vertical"
  for i in range(a:v_num - 1)
      Tnew
  endfor
  execute "wincmd t"
  "# holizonal split
  let g:neoterm_default_mod = "aboveleft"
  for i in range(a:v_num)
      for i in range(a:h_num - 1)
          Tnew
      endfor
      execute "wincmd l"
  endfor
  execute "wincmd t"
  let g:neoterm_default_mod = l:tmp_mod
  let g:neoterm_size = l:tmp_size
endfunction

nnoremap <silent><c-t><c-t> :Ttoggle<CR>
tnoremap <silent><c-t><c-t> <C-\><C-n>:Ttoggle<CR>
nnoremap <Leader>tt :Tnew<CR>
nnoremap <Leader>tv :call NTermVerticalSplit()<CR>
nnoremap <Leader>tn :TREPLSendLine<CR>j0
vnoremap <Leader>tn :TREPLSendSelection<CR>'>j0

command! -nargs=+ NTermMulti call NTermMulti(<f-args>)
command! NTermMulti4 call NTermMulti(2, 2)
command! NTermMulti2 call NTermMulti(1, 2)
command! NTermMulti1 call NTermMulti(1, 1)
