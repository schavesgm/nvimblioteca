local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end

-- Function to load telescope extensions
local function telescope_extension(extension)
    local is_ok, _ = pcall(telescope.load_extension, extension)
    if not is_ok then
        vim.notify('telescope extension ' .. extension .. ' cannot be loaded')
        return false
    end
    return true
end

-- Grab some modules
local actions = require("telescope.actions")

-- Load some telescope extensions using protected call
if telescope_extension("media_files") then
    if not vim.fn['executable']('fd') then
        vim.notify('fd cannot be found in system. Run:', vim.log.levels.WARN)
        vim.notify('   ln -s $(which fdfind) ~/.local/bin/fd', vim.log.levels.WARN)
    end
end

-- Check that ripgrep is installed in the system
local is_rg_installed = vim.fn['executable']('rg') ~= 0 and true or false
if not is_rg_installed then
    vim.notify 'rip-grep [rg] is not installed in $PATH; run "sudo apt-get install ripgrep"'
end

-- Setup telescope plugin
telescope.setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },
            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["?"] = actions.which_key,
            },
        },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg", "pdf"},
            find_cmd = "fdfind",
        }
    },
}

-- Add some telescope keybindings
vim.keymap.set('n', '<leader>f', "<cmd>Telescope find_files<cr>", {noremap = true, silent = true})
vim.keymap.set('n', '<leader>g', "<cmd>Telescope live_grep<cr>", {noremap = true, silent = true})
