-- Module used to bootstrap the configuration of gruvim
local M = {}

-- Vim has to be 0.7 at least
if vim.fn.has "nvim-0.7" ~= 1 then
    vim.notify("Please upgrade your Neovim base installation. Requires v0.7+", vim.log.levels.WARN)
    vim.wait(5000, function() return false end)
    vim.cmd "cquit"
end

-- Load all the utility global functions
require("user.globals")

function M:init()

    -- Load the default options of the system
    require("user.core.options"):init()

    -- Load the default autocommands of the system
    require("user.core.autocmds"):init()

    -- Load the default keybindings of the system
    require("user.core.keymaps"):init()

    -- -- Load the plugin configuration of the system
    require("user.core.plugins"):init()
end

-- Reload the configuration
function M:reload()
    vim.schedule(function() M:init() end)
end

return M
