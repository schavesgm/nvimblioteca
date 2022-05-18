-- Load the configuration in a secure call
local loaded, configs = pcall(require, "nvim-treesitter.configs")
if not loaded then return end

configs.setup {
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
            init_selection    = "gss",
            node_incremental  = "gin",
            node_decremental  = "gdn",
            scope_incremental = "gis",
            scope_decremental = "gds",
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
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    autopairs = {
        enable = true
    },
}
