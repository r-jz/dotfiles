set completeopt-=preview


let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
call deoplete#custom#option(
    \ 'smart_case', v:true)
call deoplete#custom#option(
    \ 'auto_complete_delay', 1)
call deoplete#custom#source(
    \ 'file', 'enable_buffer_path', v:true)
inoremap <expr><TAB> pumvisible() ? "\<C-n>": "<TAB>"
inoremap <expr><CR>  pumvisible() ? deoplete#close_popup(): "\<CR>"
