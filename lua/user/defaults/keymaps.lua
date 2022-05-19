-- Table containing the default keymaps of the system
return {
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

        -- Make the statusline global
        ['<leader>g'] = function()
            local sl_status = vim.o.laststatus
            if sl_status == 3 then
                vim.o.laststatus = 2
            else
                vim.o.laststatus = 3
            end
        end,
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
}
