function! CocCurrentFunction()
    return get (b:, 'coc_current_function', '')
endfunction

function! FilePath()
    if winwidth(0) > 90
        return expand("%:s")
    else
        return expand("%:t")
    endif
endfunction

let g:lightline = {
        \ "colorscheme": "solarized",
        \ 'active': {
                \'left': [ ['mode', 'paste'], ['cocstatus', 'currentfunction', 'readonly', 'filepath', 'modified'] ]
        \ },
        \ 'component_function':{
                \ 'cocstatus': 'coc#status',
                \ 'currentfunction': 'CocCurrentFunction',
                \ 'filepath': 'FilePath'
                        \ }
        \ }


set laststatus=2
set noshowmode

