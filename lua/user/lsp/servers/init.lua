-- Table containing some server configurations
local M = {}

local servers = {"jsonls", "sumneko_lua", "pyright", "ltex", "texlab"}
for _, name in ipairs(servers) do
    M[name] = require(string.format("user.lsp.servers.%s", name))
end

return M
