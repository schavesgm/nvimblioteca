local status_ok, feline = pcall(require, "feline")
if not status_ok then return end
local status_ok, kanagawa = pcall(require, "kanagawa.colors")
if not status_ok then return end

print(require('feline.providers.git').git_info_exists())

-- Set feline theme from kanagawa
local colors = kanagawa.setup()
local theme  = {
    fg        = colors.oldWhite,
    bg        = colors.sumiInk0, 
    black     = colors.sumiInk0,
    white     = colors.oldWhite,
    green     = colors.springGreen,
    red       = colors.peachRed,
    orange    = colors.surimiOrange,
    skyblue   = colors.springBlue,
    cyan      = colors.crystalBlue,
    oceanblue = colors.waveBlue1,
    magenta   = colors.oniViolet,
    violet    = colors.oniViolet,
    yellow    = colors.carpYellow
}

-- Define the feline components
local components = {}

-- Add the active components
components.active = {
    -- Left part of the statusline
    {
        {
            provider = 'vi_mode',
            hl = function()
                return {
                    name  = require('feline.providers.vi_mode').get_mode_highlight_name(),
                    fg    = require('feline.providers.vi_mode').get_mode_color(),
                    style = 'bold'
                }
            end,
            icon = '',
            left_sep   = {str = '  ', hl={fg=theme.oceanblue}},
            right_sep  = {str = ' '},
        },
        {
            provider = {
                name = 'file_info',
                opts = {file_modified_icon = '',}
            },
            hl = {style='bold'},
            right_sep = {str = ' '},
        },
        {
            provider = function() 
                local is_mod =  vim.fn['getbufinfo']('%')[1].changed
                return (is_mod == 1) and '  ' or ''
            end,
            hl = {fg=theme.magenta, style='bold'},
        },
        {
            provider = 'file_encoding',
            hl = {fg=theme.skyblue},
            right_sep = {str = ' '},
        },
        {
            provider = 'git_branch',
            hl = {fg = theme.orange, style = 'bold'},
            right_sep = {str='  ', hl={fg=theme.bg, bg=theme.oceanblue}},
        },
    },
    -- Center part of the statusline
    {
        {
            provider = 'diagnostic_info',
            hl = {fg=theme.orange, bg=theme.oceanblue},
            right_sep = {str = ' ', hl={fg=theme.oceanblue, bg=theme.oceanblue}},
        },
        {
            provider = 'diagnostic_hints',
            hl = {fg=theme.magenta, bg=theme.oceanblue},
            right_sep = {str = ' ', hl={fg=theme.oceanblue, bg=theme.bg}},
        },
        {
            provider = 'diagnostic_warnings',
            hl = {fg=theme.orange, bg=theme.oceanblue},
            right_sep = {str = ' '},
        },
        {
            provider = 'diagnostic_errors',
            hl = {fg=theme.red, bg=theme.oceanblue},
        },
    },
    -- Right part of the statusline
    {
        {
            provider = 'git_diff_added',
            hl = {fg=theme.green, bg=theme.oceanblue, style = 'bold'},
        },
        {
            provider = 'git_diff_changed',
            hl = {fg=theme.skyblue, bg=theme.oceanblue, style = 'bold'},
        },
        {
            provider = 'git_diff_removed',
            hl = {fg=theme.red, bg=theme.oceanblue, style = 'bold'},
        },
        {
            provider = 'line_percentage',
            hl = {fg=theme.fg, style='bold'},
            right_sep = {str = ' | ', hl={fg=theme.skyblue}},
            left_sep  = {str='  ', hl={fg=theme.oceanblue, bg=theme.bg}},
        },
        {
            provider = 'position',
            hl = {fg=theme.fg, style='bold'},
            right_sep = {str = ' '},
        },
        {
            provider = 'lsp_client_names',
            hl = {fg=theme.skyblue, bg=theme.bg, style='bold'},
        },
    },
}

-- Define the inactive components
components.inactive = {
    -- Left side of the inactive statusline
    {
        {
            provider = {
                name = 'file_info',
                opts = {file_modified_icon = '',}
            },
            hl = {style='bold'},
            right_sep = {str = ' '},
        },
        {
            provider = function() 
                local is_mod =  vim.fn['getbufinfo']('%')[1].changed
                return (is_mod == 1) and '  ' or ''
            end,
            hl = {fg=theme.magenta, style='bold'},
        },
        {
            provider = 'file_encoding',
            hl = {fg=theme.skyblue},
            right_sep = {str = ' '},
        },
        {
            provider = 'git_branch',
            hl = {fg = theme.orange, style = 'bold'},
            -- right_sep = {str=' ', hl={fg=theme.bg, bg=theme.oceanblue}},
        },
    },
    -- Right part of the inactive status bar
    {
        {
            provider = 'git_diff_added',
            hl = {fg=theme.green, bg=theme.bg, style = 'bold'},
        },
        {
            provider = 'git_diff_changed',
            hl = {fg=theme.skyblue, bg=theme.bg, style = 'bold'},
        },
        {
            provider = 'git_diff_removed',
            hl = {fg=theme.red, bg=theme.bg, style = 'bold'},
        },
    },
}

feline.setup(
    {
        theme=theme,
        components=components,
    }
)
