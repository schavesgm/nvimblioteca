-- Load the configuration file with current name
-- @name str: plugin name
local function load_config(name)
    require("user.plugins." .. name)
end

-- Table containing all the plugin definitions of the system
return {
	-- Colourschemes
	['rebelot/kanagawa.nvim'] = {config=load_config("kanagawa")},

	-- Language-server LSP
	['neovim/nvim-lspconfig']             = {},
    ['williamboman/mason.nvim']           = {config=load_config("mason")},
    ['williamboman/mason-lspconfig.nvim'] = {config=load_config("mason-lspconfig")},
	['folke/lsp-colors.nvim']             = {},
    ['rmagatti/goto-preview']             = {config=load_config("goto-preview")},
    ['kosayoda/nvim-lightbulb']           = {config=load_config("nvim-lightbulb")},
    ['weilbith/nvim-code-action-menu']    = {cmd='CodeActionMenu'},
    ['ray-x/lsp_signature.nvim']          = {},

	-- Autocompletion
	['hrsh7th/nvim-cmp']         = {config=load_config("nvim-cmp"),},
	['hrsh7th/cmp-buffer']       = {},
	['hrsh7th/cmp-path']         = {},
	['hrsh7th/cmp-cmdline']      = {},
	['hrsh7th/cmp-nvim-lsp']     = {},
	['hrsh7th/cmp-nvim-lua']     = {},
	['saadparwaiz1/cmp_luasnip'] = {},

    -- Linting
    ['mfussenegger/nvim-lint']   = {config=load_config("nvim-lint")},

    -- Text manipulation
    ['windwp/nvim-autopairs'] = {config=load_config("nvim-autopairs")},

	-- Snippets
	['L3MON4D3/LuaSnip']             = {},
	['rafamadriz/friendly-snippets'] = {},

	-- Treesitter and related
	['nvim-treesitter/nvim-treesitter'] = {run=':TSUpdate', config=load_config("nvim-treesitter"),},
	['p00f/nvim-ts-rainbow'] = {},

	-- Statusbar
	['feline-nvim/feline.nvim'] = {
	    config=load_config("feline"),
	    requires={
		{'kyazdani42/nvim-web-devicons', opts=true},
		{'lewis6991/gitsigns.nvim', opts=true},
	    }
	},

    -- Fuzzy finders
    ['nvim-telescope/telescope.nvim'] = {
        requires={
            {'nvim-lua/plenary.nvim', opts=true},
            {'nvim-lua/popup.nvim', opts=true},
        },
        config=load_config("telescope")
    },
    ['nvim-telescope/telescope-media-files.nvim'] = {},

	-- Git integration
	['lewis6991/gitsigns.nvim'] = {config=load_config("gitsigns")},

	-- Utility plugins
	['kyazdani42/nvim-web-devicons'] = {},
    ['lukas-reineke/indent-blankline.nvim'] = {config=load_config("indent-blankline")},

    -- Add some local plugins
    [join_paths(config_path, 'lua/local/formatequal.nvim')] = {config=function() require("formatequal").setup() end},
    [join_paths(config_path, 'lua/local/texpar.nvim')]      = {},
    [join_paths(config_path, 'lua/local/repl.nvim')]        = {},
}
