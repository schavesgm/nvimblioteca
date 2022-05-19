local M = {}

local utils  = require("user.utils")
local values = {"options", "autocmds", "keymaps", "plugins"}

function M.get_defaults(name)
    if not utils.is_inside_array(name, values) then
        vim.notify(string.format("%s is not a value value", name), vim.log.levels.WARN)
        vim.notify("Possible values are:", vim.log.levels.WARN)
        vim.notify(vim.inspect(values), vim.log.levels.WARN)
        return false
    end

    return require(string.format("user.defaults.%s", name))
end

return M
