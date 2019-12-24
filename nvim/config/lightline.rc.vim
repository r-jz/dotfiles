let g:lightline = {
        \ "colorscheme": "solarized",
        \ 'active': {
                \'left': [ ['mode', 'paste'], ['readonly', 'filepath', 'modified'] ]
        \ },
        \ 'component_function':{
                \ 'filepath': 'FilePath'
                        \ }
        \ }

function! FilePath()
        if winwidth(0) > 90
            return  expand("%:s")
        else
            return expand("%:t")
        endif
endfunction


set laststatus=2
set noshowmode

