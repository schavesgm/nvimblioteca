local M = {}

-- All the defined delimiters
M.DELIMITERS = {'\\begin', '\\end', '\\chapter', '\\section', '\\subsection', '\\subsubsection', '%%'}

-- Get the needed functions
local look = require'texpar.helpers'.look

function M.select_par()
    local nr = vim.fn['line']('.')
    vim.cmd('normal! ' .. look(nr, true, M.DELIMITERS) .. 'GV' .. look(nr, false, M.DELIMITERS) .. 'G')
end

return M
