-- Module used to bootstrap the configuration of gruvim
local M = {}

-- Vim has to be 0.7 at least
if vim.fn.has "nvim-0.7" ~= 1 then
    vim.notify("Please upgrade your Neovim base installation. Requires v0.7+", vim.log.levels.WARN)
    vim.wait(5000, function() return false end)
    vim.cmd "cquit"
end

-- Notify the absence of some programs before starting
local needs_presence = {'npm', 'node'}
for _, command in ipairs(needs_presence) do
    local is_present = vim.fn.executable(command) == 1
     if not is_present then
        local string = string.format('Required program %s is missing in system', command)
        vim.notify(string, vim.log.levels.ERROR)
     end
end

-- Load all the utility global functions
require("user.utils.globals")

function M:init(config_path)

    -- Set a variable with the configuration path
    _G.config_path = config_path

    -- Load the default options of the system
    require("user.core.options"):init()

    -- Load the default autocommands of the system
    require("user.core.autocmds"):init()

    -- Load the default keybindings of the system
    require("user.core.keymaps"):init()

    -- Load the plugin configuration of the system
    require("user.core.plugins"):init()

    -- Load the lsp configuration
    require("user.lsp"):init()
end

-- Reload the configuration
function M:reload()
    vim.schedule(function() M:init() end)
end

return M
