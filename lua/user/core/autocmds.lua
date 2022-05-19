local M = {}

-- Get some needed utility functions
local utils = require("user.utils")

-- Wrapper to generate autocommands
function M.create_autocmd(event, options)
    return vim.tbl_deep_extend("keep", {event=event}, options)
end

-- Define a set of autogroups with their respective autocommands
function M.set_autocommands(autocommands)
    for augroup, autocmds in pairs(autocommands) do
        local group = vim.api.nvim_create_augroup(augroup, {clear=true})

        for _, autocmd in ipairs(autocmds) do

            -- Make a deep copy of the autocmd table
            local copied_autocmd = utils.deepcopy_table(autocmd)
            local event = utils.pop_key("event", copied_autocmd)
            if event == nil then
                vim.notify 'Autocommand does not define event. Ignoring'
                goto continue
            end

            vim.api.nvim_create_autocmd(event, vim.tbl_deep_extend("keep", copied_autocmd, {group=group}))
            ::continue::
        end
    end
end

-- Set the default autocommands on the system
function M:init()
    M.set_autocommands(require("user.defaults").get_defaults("autocmds"))
end

return M
