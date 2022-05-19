local M = {}

-- Load the formatter function
local format_function = require'formatequal.formatter'.make_equal_format

-- Main function of the module, used to format the data
function M.format_hierarchically()

    -- Get the filetype of the current buffer
    local ft = vim.bo.filetype:gsub('^%l', string.upper)

    -- Get the characters to be used according to the settings
    local hierarchy_chars = M.settings[ft]

    -- If the characters are not defined, then raise and error
    if (hierarchy_chars == nil) then
        vim.notify(vim.bo.filetype .. ' is not a valid filetype for formatequal')
        return false
    end

    -- Get the line and the line number of the selection
    local lines   = vim.fn['getline'](vim.fn['line']("'<"), vim.fn['line']("'>'"))
    local line_nr = vim.fn['line']("'<") - 1

    for _, char in pairs(hierarchy_chars) do
        if format_function(lines, line_nr, char) then
            return true
        end
    end
    return false
end

-- Default options used in the system
function M.set_defaults()
    -- TODO: Update this in the future if more data is needed
    M.settings = {
        Python = {'=', ':'},
        Lua    = {'='},
        Cpp    = {'='},
        C      = {'='},
    }
end

-- Setup function used to set some hierarchical special characters
function M.setup(settings)
    -- First, set the defaults any case
    M.set_defaults()

    -- If the table passed is empty, then just continue
    if not settings then return end

    -- Merge both tables overriding the defaults
    M.settings = vim.tbl_deep_extend('force', M.settings, settings)
end

return M
