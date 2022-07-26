-- Table containing the default options of the configuration
return {
    -- Basic options
    backup        = false,                     -- Creates a backup file
    swapfile      = false,                     -- Creates a swapfile
    undofile      = true,                      -- Enable persistent undo
    writebackup   = false,                     -- Files modified by other programs while being opened cannot be edited
    guifont       = 'monospace:h17',           -- The font used in graphical neovim applications
    clipboard     = 'unnamedplus',             -- Allows neovim to access the system clipboard
    fileencoding  = 'utf-8',                   -- The encoding used in the files
    mouse         = 'a',                       -- Allow the mouse to be used in neovim
    showmode      = false,                     -- We don't need to see things like -- INSERT -- anymore
    termguicolors = true,                      -- Set term-GUI colors (most terminals support this)
    updatetime    = 300,                       -- Faster completion (4000ms default)
    timeoutlen    = 1000,                      -- Time to wait for a mapped sequence to complete (in milliseconds)
    history       = 50,                        -- Number of commands to save in memory
    conceallevel  = 0,                         -- Make the conceal level to 0 by default to allow `` to be seen in Markdown files
    cmdheight     = 1,                         -- More space in the neovim command line for displaying messages
    pumheight     = 10,                        -- Pop up menu height
    signcolumn    = 'yes',                     -- Show the sign column; the column on the left
    inccommand    = 'split',                   -- Shows the effect of a command while you type it
    infercase     = true,                      -- Allow Nvim to infer the case in autocomplete
    showtabline   = 2,                         -- Show the tablines - name of the files on top - always
    laststatus    = 3,                         -- Use a global status line by default

    -- Navigation options
    wrap           = false,                    -- Display lines as one long line instead of wrapping them
    scrolloff      = 8,                        -- Allow some at least N lines above or below the current one to be seen
    sidescrolloff  = 8,                        -- Minimal number of columns to have around the current column
    splitbelow     = true,                     -- Force all horizontal splits to go below current window
    splitright     = true,                     -- Force all vertical splits to go to the right of current window
    cursorline     = true,                     -- Highlight the current line
    numberwidth    = 2,                        -- Set number column width to 2 {default 4}
    number         = true,                     -- Set numbered lines
    relativenumber = true,                     -- Set relative numbered lines

    -- Buffer manipulation options
    hidden   = true,                           -- Do not unload a buffer when it is abandoned
    autoread = true,                           -- Load a file automatically if edited outside neovim

    -- Invisible characters options
    showbreak = "↪\\",
    listchars = "tab:→\\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨",

    -- Search options
    hlsearch   = true,                         -- Highlight all matches on previous search pattern
    ignorecase = true,                         -- Ignore case in search patterns
    smartcase  = true,                         -- Allow neovim to select if using caps or not automatically

    -- Command line menu options
    wildmenu = true,                           -- Allows enhanced command line menu
    wildmode = 'full',                         -- Show the command line possibilites according to those sorting keys

    -- Spelling options
    spelllang = 'en,es',                       -- Allow these dictionaries to be loaded

    -- Indent options
    smartindent = true,                        -- Make indenting smarter again
    autoindent  = true,                        -- Allow Neovim to infer the indentation level of the line
    expandtab   = true,                        -- Convert tabs to spaces
    tabstop     = 4,                           -- Insert 2 spaces for a tab
    shiftwidth  = 4,                           -- The number of spaces inserted for each indentation
    softtabstop = 4,                           -- Number of spaces that a <Tab> corresponds to when editing a file

    -- Special options
    completeopt = {'menuone', 'noselect'},   -- Monstly used for compe plugin
}
