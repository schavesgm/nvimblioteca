-- Securely call the completion plugin
local loaded, cmp     = pcall(require, "cmp")
if not loaded then return end
local loaded, luasnip = pcall(require, "luasnip")
if not loaded then return end

-- Load the Luasnip snippets used in VScode
require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- Define some nice icons in the autocompletion
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

-- Setup function for autocompletion
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        -- Select previous and next items using Ctrl + {k, j}
        ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),

        -- Move laterally in the docs using Ctrl + {b, f}
        ["<C-l>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), {"i", "c"}),
        ["<C-h>"] = cmp.mapping(cmp.mapping.scroll_docs(1), {"i", "c"}),

        -- Show all possible completion options
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),

        -- Disable the autocompletion engine
        ["<C-y>"] = cmp.config.disable,

        -- Exit the autocompletion
        ["<C-e>"] = cmp.mapping {i = cmp.mapping.abort(), c = cmp.mapping.close(),},

        -- Accept currently selected item
        ["<CR>"] = cmp.mapping.confirm {select = true},

        -- Use <Tab> to select items in the autocompletion
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif check_backspace() then
                    fallback()
                else
                    fallback()
                end
            end, {"i", "s",}
        ),
        -- Use shift tab to jump to luasnip expandable items
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                if luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {"i", "s",}
        ),
    },
    formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
            vim_item.menu = ({
                luasnip  = "[Snippet]",
                buffer   = "[Buffer]",
                path     = "[Path]",
                nvim_lua = "[Nvim_lua]",
                nvim_lsp = "[LSP]",
            })[entry.source.name]
            return vim_item
        end,
    },
    -- Order in which the data is presented and loaded into the autocompletion
    sources = {
        {name = "nvim_lsp"},
        {name = "nvim_lua"},
        {name = "luasnip"},
        {name = "buffer"},
        {name = "path"},
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion    = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text  = true,
    },
}
