-- Add the current path path to the runtimepath
local path = debug.getinfo(1, "S").source:sub(2)
local base_dir = path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
    vim.opt.rtp:append(base_dir)
end

require("user.bootstrap"):init(base_dir)

-- FOR_TESTS: This is how you add custom test plugins to configuration
-- vim.opt.runtimepath:append(_G.join_paths(base_dir, 'lua/local/repl.nvim'))
