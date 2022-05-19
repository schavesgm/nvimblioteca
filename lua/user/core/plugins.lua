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
