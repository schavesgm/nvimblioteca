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
