-- Table containing the definitions of the default options
local M = {}

-- Load default options with user interface
local function load_defaults()

    local defaults = require("user.defaults").get_defaults("options")
    for key, value in pairs(defaults) do
        vim.opt[key] = value
    end

    -- Some other settings
    vim.opt.shortmess:append("c")
    vim.opt.shortmess:append("I")
    vim.opt.whichwrap:append("<,>,[,],h,l")
end

-- Load default options without user interface
local function load_defaults_no_ui()
    vim.opt.shortmess = ""     -- try to prevent echom from cutting messages off or prompting
    vim.opt.more = false       -- don't pause listing when screen is filled
    vim.opt.cmdheight = 9999   -- helps avoiding |hit-enter| prompts.
    vim.opt.columns = 9999     -- set the widest screen possible
    vim.opt.swapfile = false   -- don't use a swap file
end

function M:init()
    -- If vim does not have a user-interface, load no_ui configution
    if in_headless() then
        load_defaults_no_ui()
    else
        load_defaults()
    end
end

return M
