-- Module containing the LSP-handlers
local M = {}

-- Setup function
function M.setup()

    -- Sings shown on the left side of the data
    local signs = {
        {name = "DiagnosticSignError", text = ""},
        {name = "DiagnosticSignWarn",  text = ""},
        {name = "DiagnosticSignHint",  text = ""},
        {name = "DiagnosticSignInfo",  text = "כֿ"},
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {texthl=sign.name, text=sign.text, numhl=""})
    end

    -- Configuration of the handlers
    local config = {
        virtual_text = true,
        signs = {active = signs,},
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style     = "minimal",
            border    = "rounded",
            source    = "always",
            header    = "",
            prefix    = "",
        },
    }

    -- Add the configuration of LSP
    vim.diagnostic.config(config)

    --- Add some handlers to the configuration
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
        [[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],
        false
        )
    end
end

-- Set some keymaps for LSP management
local function lsp_keymaps(bufnr)

    -- Overall basic options for all keymaps
    local opts = {noremap = true, silent = true, buffer=bufnr}

    -- Set the buffer definitions
    vim.keymap.set('n', 'gd',    vim.lsp.buf.definition,     opts)
    vim.keymap.set('n', 'gD',    vim.lsp.buf.declaration,    opts)
    vim.keymap.set('n', 'gi',    vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr',    vim.lsp.buf.references,     opts)
    vim.keymap.set('n', 'gl',    vim.diagnostic.open_float,  opts)
    vim.keymap.set('n', 'K',     vim.lsp.buf.hover,          opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({border="rounded"}) end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({border="rounded"}) end, opts)

    vim.keymap.set('n', '<leader>q',  vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,        opts)

    -- Code action mapping
    local callback = vim.fn['exists'](':CodeActionMenu') and ":CodeActionMenu<Cr>" or vim.lsp.buf.code_action
    vim.keymap.set('n', '<leader>ca', callback, opts)

    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
    -- On attach function to attach some highlighting and keymaps
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    end
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Add the autocompletion to lsp
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then return end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
