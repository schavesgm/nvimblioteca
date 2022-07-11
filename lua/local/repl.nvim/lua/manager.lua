local M = {}

-- Load some needed modules
local utils = require("utils.helpers")

-- Setup function for the manager
function M.setup(config)
    -- Table containing all opened REPLs
    M.instances = {}

    -- First, set the default values in the module
    M.config = {
        default_positions = {
            {X = "R", Y = "T", W = 0.35, H = 0.30},
            {X = "R", Y = "M", W = 0.35, H = 0.30},
            {X = "R", Y = "B", W = 0.35, H = 0.30},
        },
        filetype_repl = {
            python = 'ipython',
            lua    = 'lua',
        },
        ignore_funcs = {
            python = function(line)
                return line ~= '' and not utils.string_starts(line, '#')
            end,
            lua    = function(line)
                return line ~= '' and not utils.string_starts(line, '--')
            end
        },
        use_conditions  = true,
        set_keybindings = true,
    }
    -- Set the keybindings if wanted
    if M.config.set_keybindings then M.set_keybinds() end

    -- Update the configuration depending on the input table
    if config == nil then return end
    M.config.default_positions = config.default_positions or M.config.default_positions
    M.config.use_conditions    = config.use_conditions or M.config.use_conditions

    if config.filetype_repl ~= nil then
        M.config.filetype_repl = vim.tbl_deep_extend(
            M.config.filetype_repl, config.filetype_repl, "force"
        )
    end
    if config.ignore_funcs ~= nil then
        M.config.ignore_funcs = vim.tbl_deep_extend(
            M.config.ignore_funcs, config.ignore_funcs, "force"
        )
    end
end

-- Set some default keybindings to manipulate REPL terminals
function M.set_keybinds()
    -- Set some default keybindings
    local opts = {silent=true, noremap=true}
    vim.keymap.set('n', '<leader>ro', function() M.open_repl() end, opts)
    vim.keymap.set('n', '<leader>rt', function() M.toggle_repl() end, opts)
    vim.keymap.set('n', '<leader>rc', function() M.close_repl() end, opts)
    vim.keymap.set('n', '<leader>rf', function() M.focus_repl() end, opts)
    vim.keymap.set('n', '<C-Right>',  function() M.move_repl_horizontal(true) end, opts)
    vim.keymap.set('n', '<C-Left>',   function() M.move_repl_horizontal(false) end, opts)
    vim.keymap.set('n', '<C-Up>',     function() M.move_repl_vertical(true) end, opts)
    vim.keymap.set('n', '<C-Down>',   function() M.move_repl_vertical(false) end, opts)
    vim.keymap.set('n', '<A-Right>',  function() M.resize_repl_width(true) end, opts)
    vim.keymap.set('n', '<A-Left>',   function() M.resize_repl_width(false) end, opts)
    vim.keymap.set('n', '<A-Up>',     function() M.resize_repl_height(true) end, opts)
    vim.keymap.set('n', '<A-Down>',   function() M.resize_repl_height(false) end, opts)

    -- Send some data to the replt
    vim.keymap.set('n', 'sl', function() M.send_repl_line() end, opts)
    vim.keymap.set('n', 'sw', function() M.send_repl_word() end, opts)
    vim.keymap.set('n', 'sf', function() M.send_repl_file() end, opts)
    vim.keymap.set('v', 'sl', function() M.send_repl_block() end, opts)
end

-- Basic functionality of the manager {{{
function M.open_repl()
    -- Get some needed variables
    local filetype   = vim.bo.filetype
    local num_opened = utils.table_length(M.instances)
    local config     = M.config

    -- Only open a filetype for
    if config.filetype_repl[filetype] == nil then
        vim.notify('ERROR: Current filetype cannot be used as REPL', vim.log.levels.ERROR)
        return
    end

    if M.instances[filetype] ~= nil then
        vim.notify('WARN: Current filetype has an already opened REPL terminal', vim.log.levels.WARN)
        return
    else
        M.instances[filetype] = require("core.repl")(config.filetype_repl[filetype])
        M.instances[filetype]:open(
            config.default_positions[num_opened % utils.table_length(config.default_positions) + 1]
        )
    end
end

function M.close_repl()
    local filetype = vim.bo.filetype
    if M.instances[filetype] ~= nil then
        -- Close the repl if already opened
        if M.instances[filetype].is_opened then
            M.instances[filetype]:close()
        end
        M.instances[filetype] = nil
    end
end

function M.toggle_repl()
    local filetype = vim.bo.filetype
    M.instances[filetype]:toggle_terminal()
end

function M.focus_repl()
    local filetype = vim.bo.filetype
    local repl     = M.instances[filetype]

    if not repl.float.is_visible then repl:toggle() end
    vim.api.nvim_set_current_win(repl.float.window)
end

function M.is_opened()
    return M.instances[vim.bo.filetype] ~= nil
end
-- }}}

-- Some needed methods to move the floating window
function M.resize_repl_width(increment)
    if not M.is_opened() then
        vim.notify('ERROR: Filetype does not contain an opened REPL', vim.log.levels.ERROR)
        return
    end
    M.instances[vim.bo.filetype]:resize_width(increment)
end
function M.resize_repl_height(increment)
    if not M.is_opened() then
        vim.notify('ERROR: Filetype does not contain an opened REPL', vim.log.levels.ERROR)
        return
    end
    M.instances[vim.bo.filetype]:resize_height(increment)
end
function M.move_repl_horizontal(increment)
    if not M.is_opened() then
        vim.notify('ERROR: Filetype does not contain an opened REPL', vim.log.levels.ERROR)
        return
    end
    M.instances[vim.bo.filetype]:move_horizontal(increment)
end
function M.move_repl_vertical(increment)
    if not M.is_opened() then
        vim.notify('ERROR: Filetype does not contain an opened REPL', vim.log.levels.ERROR)
        return
    end
    M.instances[vim.bo.filetype]:move_vertical(increment)
end

-- Some needed functions to communicate with the REPL
function M.send_repl_line()
    if not M.is_opened() then
        vim.notify('ERROR: Filetype does not contain an opened REPL', vim.log.levels.ERROR)
        return
    end
    M.instances[vim.bo.filetype]:send_message(vim.api.nvim_get_current_line())
end
function M.send_repl_word()
    if not M.is_opened() then
        vim.notify('ERROR: Filetype does not contain an opened REPL', vim.log.levels.ERROR)
        return
    end
    M.instances[vim.bo.filetype]:send_message(vim.fn.expand('<cword>'))
end
function M.send_repl_block()
    if not M.is_opened() then
        vim.notify('ERROR: Filetype does not contain an opened REPL', vim.log.levels.ERROR)
        return
    end

    -- Get some needed variables
    local filetype  = vim.bo.filetype
    local config    = M.config
    local condition = config.use_conditions and config.ignore_funcs[filetype] or nil

    M.instances[filetype]:send_message(utils.get_visual_selection(condition))
end
function M.send_repl_file()
    if not M.is_opened() then
        vim.notify('ERROR: Filetype does not contain an opened REPL', vim.log.levels.ERROR)
        return
    end

    -- Get some needed variables
    local filetype  = vim.bo.filetype
    local config    = M.config
    local condition = config.use_conditions and config.ignore_funcs[filetype] or nil

    M.instances[filetype]:send_message(utils.get_whole_file(condition))
end

return M
