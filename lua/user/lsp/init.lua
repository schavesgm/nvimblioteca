local M = {}

function M:init()

    -- Check if LSP is available
    local status_ok, _ = pcall(require, "lspconfig")
    if not status_ok then
        vim.notify('lspconfig cannot be accesed. Ignoring', vim.log.levels.WARN)
        return
    end

    -- Load the LSP configuration
    require("user.lsp.installer")
    require("user.lsp.handlers").setup()
end

return M
