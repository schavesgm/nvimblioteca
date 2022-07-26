local status_ok, lint = pcall(require, "lint")
if not status_ok then return end

local autocmd = require("user.core.autocmds")

-- Set the linters
lint.linters_by_ft = {
    lua    = {'luacheck'},
    python = {'mypy'},
}

-- -- Set some autocommands to trigger linters
-- autocmd.set_augroup_autocmds({
--     LinterTrigger = {
--         autocmd.create_autocmd("BufWritePost", {callback=function()
--             require("lint").try_lint()
--         end})
--     }
-- })
