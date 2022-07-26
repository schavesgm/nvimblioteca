-- Set some autocommands to highlight the document accordingly
local function lsp_highlight_document(client)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false)
    end
end

-- Set some lsp keymaps
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

return {
    lsp_highlight_document = lsp_highlight_document,
    lsp_keymaps            = lsp_keymaps,
}
