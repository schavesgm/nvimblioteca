local loaded, kanagawa = pcall(require, "kanagawa")
if not loaded then return end

-- Setup kanagawa module
kanagawa.setup{}

-- Set kanagawa as the colourscheme of the system
vim.cmd [[colorscheme kanagawa]]
