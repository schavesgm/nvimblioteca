" Define a mapping to the local function
augroup TexPar
    autocmd FileType tex,markdown :onoremap <silent> ip :lua require'texpar'.select_par()<Cr>
    autocmd FileType tex,markdown :vnoremap <silent> ip :lua require'texpar'.select_par()<Cr>
augroup END
