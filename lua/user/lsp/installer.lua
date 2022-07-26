local status_1, lspconfig = pcall(require, "lspconfig")
local status_2, mason     = pcall(require, "mason-lspconfig")
local status_3, cmp_lsp   = pcall(require, "cmp_nvim_lsp")
if not status_1 or not status_2 then return end

-- Function to be called when attaching
local function on_attach(client, bufnr)
    -- On attach function to attach some highlighting and keymaps
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    end

    -- Set some required functionalities on attach
    require("user.lsp.utils").lsp_highlight_document(client)
    require("user.lsp.utils").lsp_keymaps(bufnr)

    local status_ok, lsp_signature = pcall(require, "lsp_signature")
    if status_ok then
        lsp_signature.on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {"rounded"},
        }, bufnr)
    end
end

-- Get all the server settings
local server_configs = require("user.lsp.servers")

-- Iterate through all pairs 
for _, server in ipairs(mason.get_installed_servers()) do

    -- Basic server configuration
    local config = {
        on_attach    = on_attach,
        capabilities = status_3 and cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()) or nil
    }

    -- If a configuration is present, then add it
    if server_configs[server] ~= nil then
        config = vim.tbl_deep_extend("force", config, server_configs[server])
    end

    -- Call the setup method
    lspconfig[server].setup(config)
end
