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
            vim.api.nvim_del_keymap(mode, key)
        end
    end
end

-- Set all the keymaps contained in table
-- @param (table) table containing all keymaps
function M.set_keymaps(keymaps)
    for mode, mappings in pairs(keymaps) do
        if (mode_names[mode] == nil) then
            vim.notify(mode .. ' is not an available mode. Ignoring')
            vim.notify('Available keys are:')
            vim.notify(vim.inspect(utils.get_keys(mode_names)))
            goto continue
        end

        local mode_name = mode_names[mode]

        for key, value in pairs(mappings) do
            local opts = base_options[mode_name] or {noremap=true, silent=true}
            local maps = value

            if type(value) == "table" then
                maps = value[1]
                opts = value[2]
            end

            -- If the value is nil, delete the mapping instead
            if maps then
                vim.api.nvim_set_keymap(mode_name, key, maps, opts)
            else
                pcall(vim.api.nvim_del_keymap, mode_name, key)
            end
        end
        ::continue::
    end
end

function M:init()
    M.set_keymaps(require("user.config.defaults").keymaps)
end

return M
