local create_autocmd = require("user.config.autocmds").create_autocmd

-- Load the configuration file with current name
-- @name str: plugin name
local function load_config(name)
    require("user.plugins.external." .. name)
end

return {

    -- Define the plugins of the system {{{
    plugins = {

        -- Colourschemes
        ['rebelot/kanagawa.nvim'] = {config=load_config("kanagawa")},

        -- Language-server LSP
        ['neovim/nvim-lspconfig'] = {},
        ['williamboman/nvim-lsp-installer'] = {},
        ['folke/lsp-colors.nvim'] = {},

        -- Autocompletion
        ['hrsh7th/nvim-cmp']         = {config=load_config("nvim-cmp"),},
        ['hrsh7th/cmp-buffer']       = {},
        ['hrsh7th/cmp-path']         = {},
        ['hrsh7th/cmp-cmdline']      = {},
        ['hrsh7th/cmp-nvim-lsp']     = {},
        ['hrsh7th/cmp-nvim-lua']     = {},
        ['saadparwaiz1/cmp_luasnip'] = {},

	    -- Snippets
        ['L3MON4D3/LuaSnip']             = {},
    	['rafamadriz/friendly-snippets'] = {},

        -- Treesitter and related
        ['nvim-treesitter/nvim-treesitter'] = {
           run=':TSUpdate', 
           config=load_config("nvim-treesitter"),
        },
        ['p00f/nvim-ts-rainbow'] = {},

        -- Statusbar
        ['feline-nvim/feline.nvim'] = {
            config=load_config("feline"),
            requires={
                {'kyazdani42/nvim-web-devicons', opts=true},
                {'lewis6991/gitsigns.nvim', opts=true},
            }
        },

        -- Git integration
        ['lewis6991/gitsigns.nvim'] = {config=function() require("gitsigns").setup() end},

        -- Utility plugins
        ['kyazdani42/nvim-web-devicons'] = {},

--     use {'NTBBloodbath/galaxyline.nvim', requires={'kyazdani42/nvim-web-devicons', opt=true}, config=get_ext_config('galaxyline')}

--     use {'NTBBloodbath/galaxyline.nvim', requires={'kyazdani42/nvim-web-devicons', opt=true}, config=get_ext_config('galaxyline')}
--     use {'SmiteshP/nvim-gps', config = function() require('nvim-gps').setup() end, requires = 'nvim-treesitter/nvim-treesitter'}

    },
    -- }}}

    -- Define the default autocommands of the system {{{
    autocmds = {
        RestoreCursor = {
            create_autocmd("BufRead", {pattern="*", command=[[call setpos(".", getpos("'\""))]]})
        },
        TerminalJob = {
            create_autocmd("TermOpen", {pattern="*", command=[[tnoremap <buffer> <Esc> <c-\><c-n>]]}),
            create_autocmd("TermOpen", {pattern="*", command="startinsert"}),
            create_autocmd("TermOpen", {pattern="*", command=[[setlocal nonumber norelativenumber]]}),
            create_autocmd("TermOpen", {pattern="*", command=[[setlocal filetype=term]]}),
        },
        SaveToShada = {
            create_autocmd("VimLeave", {pattern="*", command="wshada!"}),
        },
        MarkupAutocmds = {
            create_autocmd("FileType", {pattern={"tex", "text", "markdown"}, command=[[setlocal textwidth=100 colorcolumn=100]]}),
            create_autocmd("FileType", {pattern={"tex", "text", "markdown"}, command=[[setlocal spell]]}),

            -- TODO: These ones should be called only if TexLab is installed
            -- create_autocmd("FileType", {pattern="tex", command=[[nnoremap <silent> <leader>r :TexlabBuild<Cr>]]}),
            -- create_autocmd("FileType", {pattern="tex", command=[[nnoremap <silent> <leader>t :TexlabForward<Cr>]]}),
        },
    },
    -- }}}

    -- Define the default keybindings of the system {{{
    keymaps = {
        -- Insert mode keybindings
        insert_mode = {
            -- Move current line / block with Alt-j/k ala vscode.
            ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
            ["<A-k>"] = "<Esc>:m .-2<CR>==gi",

            -- Navigation
            ["<A-Up>"] = "<C-\\><C-N><C-w>k",
            ["<A-Down>"] = "<C-\\><C-N><C-w>j",
            ["<A-Left>"] = "<C-\\><C-N><C-w>h",
            ["<A-Right>"] = "<C-\\><C-N><C-w>l",
        },

        -- Normal mode mappings
        normal_mode = {
            -- Better window movement
            ["<C-h>"] = "<C-w>h",
            ["<C-j>"] = "<C-w>j",
            ["<C-k>"] = "<C-w>k",
            ["<C-l>"] = "<C-w>l",

            -- Lexplore navigation
            ["<leader>e"] = ":Lex 30<Cr>",

            -- Buffer movement
            ["[b"] = ":bprevious<CR>",
            ["]b"] = ":bnext<CR>",
            ["[B"] = ":bfirst<CR>",
            ["]B"] = ":blast<CR>",

            -- Resize with arrows
            ["<C-Up>"] = ":resize -2<CR>",
            ["<C-Down>"] = ":resize +2<CR>",
            ["<C-Left>"] = ":vertical resize -2<CR>",
            ["<C-Right>"] = ":vertical resize +2<CR>",

            -- Move current line / block with Alt-j/k a la vscode.
            ["<A-j>"] = ":m .+1<CR>==",
            ["<A-k>"] = ":m .-2<CR>==",

            -- Reload the configuration
            ['<leader>r'] = ':source $MYVIMRC<CR>',

            -- Show the invisible characters
            ['<leader>l'] = ':set list!<CR>',
        },

        -- Terminal model mappings
        terminal_mode = {
            -- Terminal window navigation
            ["<C-h>"] = "<C-\\><C-N><C-w>h",
            ["<C-j>"] = "<C-\\><C-N><C-w>j",
            ["<C-k>"] = "<C-\\><C-N><C-w>k",
            ["<C-l>"] = "<C-\\><C-N><C-w>l",
        },

        -- Visual mode mappings
        visual_mode = {
            -- Better indenting
            ["<"] = "<gv",
            [">"] = ">gv",
        },

        -- Visual block mode mappings
        visual_block_mode = {
            -- Move selected line / block of text in visual mode
            ["K"] = ":move '<-2<CR>gv-gv",
            ["J"] = ":move '>+1<CR>gv-gv",

            -- Move current line / block with Alt-j/k ala vscode.
            ["<A-j>"] = ":m '>+1<CR>gv-gv",
            ["<A-k>"] = ":m '<-2<CR>gv-gv",
        },

        -- Command mode mappings
        command_mode = {
            -- navigate tab completion with <c-j> and <c-k>; runs conditionally
            ["<C-j>"] = {'pumvisible() ? "\\<C-n>" : "\\<C-j>"', {expr = true, noremap = true}},
            ["<C-k>"] = {'pumvisible() ? "\\<C-p>" : "\\<C-k>"', {expr = true, noremap = true}},
        },
    },
    -- }}}
}
