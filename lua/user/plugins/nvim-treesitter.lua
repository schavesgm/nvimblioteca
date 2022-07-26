-- Load the configuration in a secure call
local loaded, treesitter = pcall(require, "nvim-treesitter.configs")
if not loaded then return end

treesitter.setup {
    -- Ensure all maintained extensions are installed
    ensure_installed = "all",
    sync_install = true,

    -- Treesitter highlighting module
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    -- Treesitter incremental selection module
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection    = "<leader>w",
            node_incremental  = "]w",
            node_decremental  = "[w",
        },
    },

    -- Treesitter indentation module
    indent = {
        enable = true,
    },

    -- External modules
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    autopairs = {
        enable = true
    },
}
