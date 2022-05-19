local create_autocmd = require("user.core.autocmds").create_autocmd

-- Table containing all autogroups/autocommands definitions
return {
        RestoreCursor = {
            create_autocmd("BufRead", {pattern="*", command=[[call setpos(".", getpos("'\""))]]})
        },
        TerminalJob = {
            create_autocmd("TermOpen", {pattern="*", command=[[tnoremap <buffer> <Esc> <c-\><c-n>]]}),
            create_autocmd("TermOpen", {pattern="*", command="startinsert"}),
            create_autocmd("TermOpen", {pattern="*", command=[[setlocal nonumber norelativenumber]]}),
            create_autocmd("TermOpen", {pattern="*", command=[[setlocal filetype=term]]}),
        },
        SaveToShada = {
            create_autocmd("VimLeave", {pattern="*", command="wshada!"}),
        },
        MarkupAutocmds = {
            create_autocmd("FileType", {pattern={"tex", "text", "markdown"}, command=[[setlocal textwidth=100 colorcolumn=100]]}),
            create_autocmd("FileType", {pattern={"tex", "text", "markdown"}, command=[[setlocal spell]]}),

            -- TODO: These ones should be called only if TexLab is installed
            -- create_autocmd("FileType", {pattern="tex", command=[[nnoremap <silent> <leader>r :TexlabBuild<Cr>]]}),
            -- create_autocmd("FileType", {pattern="tex", command=[[nnoremap <silent> <leader>t :TexlabForward<Cr>]]}),
        },
}
