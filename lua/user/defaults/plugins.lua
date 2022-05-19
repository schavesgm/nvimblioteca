-- Load the configuration file with current name
-- @name str: plugin name
local function load_config(name)
    require("user.plugins.external." .. name)
end

-- Table containing all the plugin definitions of the system
return {

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
}
