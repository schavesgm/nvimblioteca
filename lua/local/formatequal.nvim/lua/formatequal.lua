local M = {}

-- Load the formatter function
local format_function = require'formatequal.formatter'.make_equal_format

-- Local variable that sets None to a given filetype
M.IGNORE = 0

-- Main function of the module, used to format the data
function M.format_hierarchically()

    local ft       = vim.bo.filetype:gsub('^%l', string.upper)
    local settings = M.settings[ft]

    -- If settings is IGNORE, ignore this call
    if settings == M.IGNORE then
        vim.notify(string.format('formatequal is ignored in %s files', ft), vim.log.levels.WARN)
        return
    end

    local hierarchy = {'='}
    if settings then
        hierarchy = settings
    end

    local lines   = vim.fn['getline'](vim.fn['line']("'<"), vim.fn['line']("'>'"))
    local line_nr = vim.fn['line']("'<") - 1
    for _, char in pairs(hierarchy) do
        if format_function(lines, line_nr, char) then
            return true
        end
    end
    return false
end

-- Default options used in the system
function M.set_defaults()
    M.settings = {
        Python   = {'=', ':'},
        Tex      = M.IGNORE,
        Markdown = M.IGNORE,
    }
end

-- Setup function used to set some hierarchical special characters
function M.setup(settings)
    M.set_defaults()
    if not settings then return end
    M.settings = vim.tbl_deep_extend('force', M.settings, settings)
end

return M
