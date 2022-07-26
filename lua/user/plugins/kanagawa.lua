local loaded, kanagawa = pcall(require, "kanagawa")
if not loaded then return end

-- Setup kanagawa module
kanagawa.setup{}

-- Get the colours from kanagawa
local colors = require("kanagawa.colors").setup()

-- Set kanagawa as the colourscheme of the system
vim.cmd [[colorscheme kanagawa]]

-- Set some custom highlights on this colourscheme
vim.api.nvim_set_hl(0, 'WinSeparator',               {bg=nil, fg=colors.crystalBlue, bold=true})
vim.api.nvim_set_hl(0, 'IndentBlanklineChar',        {bg=nil, fg=colors.sumiInk2, bold=true})
vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', {bg=nil, fg=colors.oniViolet, bold=true})
