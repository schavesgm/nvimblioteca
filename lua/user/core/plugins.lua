local M = {}

local fn = vim.fn
local autocmds = require("user.core.autocmds")

function M:init()

    -- Path where packer will be installed
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        -- Command to run to bootstrap packer
        PACKER_BOOTSTRAP = fn.system {
            "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path,
        }
        vim.cmd [[packadd packer.nvim]]
        print "Installing Packer; close and re-open Neovim..."
    end

    -- Add an autocommand to synchronize Packer once it is written
    autocmds.set_autocommands({
        PackerUserConfig = {
            autocmds.create_autocmd(
                "BufWritePost",
                {pattern="plugins.lua", command=[[source <afile> | PackerSync]]}
            ),
        }
    })

    -- Load packer
    local status_ok, packer = pcall(require, "packer")
    if not status_ok then
        print "ERROR: Packer cannot be found in the system"
        return
    end

    -- Allow packer to use a floating window
    packer.init {
        display = {
            open_fn = function()
                return require("packer.util").float({border = "single"})
            end,
        },
    }

    -- Initialise packer
    packer.startup(function(use)
	    -- Allow packer to manage itself
	    use {'wbthomason/packer.nvim'}

        for name, table in pairs(require("user.defaults").get_defaults("plugins")) do
            local plugin_config = vim.tbl_deep_extend("keep", {name}, table)
            use (plugin_config)
        end

        -- Put this at the end after all plugins
        if PACKER_BOOTSTRAP then
            require('packer').sync()
        end
    end)
end

return M

--     -- Include some basic needed plugins
--     use {"nvim-lua/popup.nvim"}
--     use {"nvim-lua/plenary.nvim"}
-- 
--     -- Colour-schemes
--     use {'rebelot/kanagawa.nvim', config=function() require('kanagawa').setup{} end}
--     use {'sainnhe/gruvbox-material'}
-- 
--     -- Add some local plugins
--     use {'~/.config/nvim/lua/local/csflipper.nvim', config = get_local_config('csflipper')}
--     use {'~/.config/nvim/lua/local/formatequal.nvim', config = get_local_config('formatequal')}
--     use {'~/.config/nvim/lua/local/texpar.nvim'}
-- 
--     -- Language-server LSP
--     use {"neovim/nvim-lspconfig"}
--     use {"williamboman/nvim-lsp-installer"}
--     use {"folke/lsp-colors.nvim"}
-- 
--     -- Autocompletion plugins
--     use {"hrsh7th/nvim-cmp", config = get_ext_config('nvim-cmp')}
--     use {"hrsh7th/cmp-buffer"}
--     use {"hrsh7th/cmp-path"}
--     use {"hrsh7th/cmp-cmdline"}
--     use {"hrsh7th/cmp-nvim-lsp"}
--     use {"hrsh7th/cmp-nvim-lua"}
--     use {"saadparwaiz1/cmp_luasnip"}
-- 
--     -- Snippets plugins
--     use "L3MON4D3/LuaSnip"
--     use "rafamadriz/friendly-snippets"
-- 
--     -- Treesitter plugins and related plugins
--     use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate', config=get_ext_config('nvim-treesitter')}
--     use {"p00f/nvim-ts-rainbow"}
-- 
--     -- Statusbar
--     use {'NTBBloodbath/galaxyline.nvim', requires={'kyazdani42/nvim-web-devicons', opt=true}, config=get_ext_config('galaxyline')}
--     use {'SmiteshP/nvim-gps', config = function() require('nvim-gps').setup() end, requires = 'nvim-treesitter/nvim-treesitter'}
-- 
--     -- Buffer line: tabline
--     use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons', config=get_ext_config('bufferline')}
-- 
--     -- Fuzzy finding
--     use {"nvim-telescope/telescope.nvim", config = get_ext_config("telescope")}
-- 
--     -- Close the brackets, parenthesis and so on automatically
--     use {'windwp/nvim-autopairs', config = get_ext_config("nvim-autopairs")}
-- 
--     -- Visual indentation guidelines
--     use {'lukas-reineke/indent-blankline.nvim', config = get_ext_config("indent-blankline")}
-- 
--     -- Git integration
--     use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}, config = get_ext_config('gitsigns')}
-- 
--     -- Terminal integration
--     use {'akinsho/toggleterm.nvim', config = get_ext_config('toggleterm')}
-- 
--     -- Run code on a REPL for quick checks
--     use {'michaelb/sniprun', run = 'bash ./install.sh', config = get_ext_config('sniprun')}
-- 
--     -- Neovim development
--     use {'svermeulen/vimpeccable'}
-- 
--     -- Utility plugins
--     use {"folke/which-key.nvim", config = function() require("which-key").setup{} end}
-- 
--     -- Automatically set up your configuration after cloning packer.nvim
--     if PACKER_BOOTSTRAP then
--         require("packer").sync()
-- end)
