local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then return end

-- Get all server settings
local all_server_opts = require("user.lsp.servers")

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
    -- Options for the server attachment
    local opts = {
 	    on_attach    = require("user.lsp.handlers").on_attach,
 	    capabilities = require("user.lsp.handlers").capabilities,
 	}

    local server_opts = all_server_opts[server.name]
    if server_opts then
 	    opts = vim.tbl_deep_extend("force", opts, server_opts)
    end

 	-- This setup() function is exactly the same as lspconfig's setup function.
    server:setup(opts)
end)

-- 
--     -- Add JSON LSP configuration
-- 	if server.name == "jsonls" then
-- 	    local jsonls_opts = require("user.lsp.settings.jsonls")
-- 	    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
-- 	end
-- 
--     -- Add LUA LSP configuration
-- 	if server.name == "sumneko_lua" then
-- 	    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
-- 	    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
-- 	end
-- 
--     -- Add Python LSP configuration
-- 	if server.name == "pyright" then
-- 	    local pyright_opts = require("user.lsp.settings.pyright")
-- 	    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
-- 	end
-- 
--     -- Add LTeX LSP configuration
--     if server.name == "ltex" then
-- 	    local ltex_opts = require("user.lsp.settings.ltex")
-- 	    opts = vim.tbl_deep_extend("force", ltex_opts, opts)
--     end
-- 
--     -- Add TexLab LSP configuration
--     if server.name == "texlab" then
-- 	    local texlab_opts = require("user.lsp.settings.texlab")
-- 	    opts = vim.tbl_deep_extend("force", texlab_opts, opts)
--     end
-- 
--     -- Add Clangd LSP configuration
--     if server.name == "clangd" then
-- 	    local clangd_opts = require("user.lsp.settings.clangd")
-- 	    opts = vim.tbl_deep_extend("force", clangd_opts, opts)
--     end
-- 
-- 	-- This setup() function is exactly the same as lspconfig's setup function.
-- 	server:setup(opts)
-- end)
