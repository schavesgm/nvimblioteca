local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then return end
local util = lspconfig.util

-- Get the root of the project, which is where .latexmkrc, main.tex or the git repository
local function get_root(fname)
    return util.root_pattern('.latexmkrc', 'main.tex')(fname) or util.find_git_ancestor(fname)
end

-- Create two autocommands for texlab
local autocmds = require("user.core.autocmds")
local group = vim.api.nvim_create_augroup("TexLab", {clear=false})
autocmds.set_augroup_autocmds({
    TexLab = {
        autocmds.create_autocmd("FileType",
            {pattern="tex", command=[[nnoremap <silent> <leader>r :TexlabBuild<Cr>]], group=group}
        ),
        autocmds.create_autocmd("FileType",
            {pattern="tex", command=[[nnoremap <silent> <leader>t :TexlabForward<Cr>]], group=group}
        ),
    }
})

return  {
    cmd = {"texlab"},
    filetypes = {"tex", "lib"},
    root_dir = function(fname)
        return util.root_pattern('.latexmkrc', 'main.tex')(fname) or util.find_git_ancestor(fname)
    end,
    settings = {
        texlab = {
            auxDirectory = ".",
            build = {
                args = {"-pdf", "-interaction=nonstopmode", "-synctex=1", "-lualatex", get_root("%f")},
                executable = "latexmk",
                forwardSearchommandsAfter = false,
                onSave = false
            },
            chktex = {
                onEdit = true,
                onOpenAndSave = true
            },
            diagnosticsDelay = 300,
            forwardSearch = {
                executable = "okular",
                args = {"--unique",  "file:%p#src:%l%f"},
            },
            bibtexFormatter = "latexindent",
            latexFormatter = "latexindent",
            formatterLineLength = 100,
            latexindent = {
                modifyLineBreaks = true
            },
        }
    }
}
