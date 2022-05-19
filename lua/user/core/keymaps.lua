local M = {}

local utils = require("user.utils")

-- Dictionary containing the basic options for each mode
local base_options = {
    insert_mode       = {noremap=true, silent=true},
    normal_mode       = {noremap=true, silent=true},
    visual_mode       = {noremap=true, silent=true},
    command_mode      = {noremap=true, silent=true},
    visual_block_mode = {noremap=true, silent=true},
    terminal_mode     = {noremap=true, silent=true},
}

-- Dictionary containing the mode names
local mode_names = {
    insert_mode       = 'i',
    normal_mode       = 'n',
    visual_mode       = 'v',
    command_mode      = 'c',
    visual_block_mode = 'x',
    terminal_mode     = 't'
}

-- Unset all the keymaps contained in table
-- @param (table) table containing all keymaps
function M.unset_keymaps(keymaps)
    for mode, mappings in pairs(keymaps) do
        for key, _ in pairs(mappings) do
            vim.keymap.del(mode, key)
        end
    end
end

-- Set all the keymaps contained in table
-- @param (table) table containing all keymaps
function M.set_keymaps(keymaps)
    for mode, mappings in pairs(keymaps) do
        local mode_name = mode_names[mode]
        if (mode_name == nil) then
            vim.notify(mode .. ' is not an available mode. Ignoring')
            vim.notify('Available modes are:')
            vim.notify(vim.inspect(utils.get_keys(mode_names)))
            goto continue
        end

        -- Set the mapping, the key contains the command and then the result
        for lhs, rhs in pairs(mappings) do

            -- If the rhs is nil, then delete the mapping
            if not rhs then
                vim.keymap.del(mode_name, lhs)
            end

            local mapping = rhs
            local options = base_options[mode]

            -- If the mapping is a table, then process it
            if type(rhs) == "table" then
                mapping = rhs.rhs  or rhs[1]
                options = rhs.opts or rhs[2]
            end

            vim.keymap.set(mode_name, lhs, mapping, options)
        end
        ::continue::
    end
end

function M:init()
    M.set_keymaps(require("user.defaults").get_defaults("keymaps"))
end

return M
