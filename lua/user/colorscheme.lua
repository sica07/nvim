--[[require("tokyonight").setup({
  style = "storm",
  transparent = true,
  transparent_sidebar=true,
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  hide_inactive_status_line = true,
  colors = { hint = "orange", error = "#ff0000" },
  styles = {
    keywords = {bold=true, italic=false},
    functions = {italic=true},
    sidebars = "transparent",
    float = "transparent",
  }
})]]
vim.cmd [[
try
" colorscheme paper
"colorscheme sunbather
colorscheme nord
"colorscheme noirbuddy
set background=dark
"colorscheme sunbather
" colorscheme everforest
"colorscheme phoenix
"PhoenixGreenEighties
" set background=dark
" colorscheme skull
" colorscheme zenwritten
"colorscheme paramount
"colorscheme zenburned
"colorscheme deus
"colorscheme zenbones
"catch /^Vim\%((\a\+)\)\=:E185/
"colorscheme tokyonight-storm

"Set transparent
"au ColorScheme * hi! Normal ctermbg=none guibg=none
"au ColorScheme * hi! SignColumn ctermbg=none guibg=none
"au ColorScheme * hi! NormalNC ctermbg=none guibg=none
"au ColorScheme * hi! MsgArea ctermbg=none guibg=none
"au ColorScheme * hi! TelescopeBorder ctermbg=none guibg=none
"au ColorScheme * hi! NvimTreeNormal ctermbg=none guibg=none
"let &fcs='eob: '

endtry
]]

require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = true,
    extend_background_behind_borders = true,

    enable = {
        -- terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = false,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    highlight_groups = {
        Comment = { fg = "muted", italic},
        VertSplit = { fg = "muted", bg = "muted" },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
    end,
})

-- SETTINGS FOR NOIRBUDDY
-- local Color, colors, Group, groups, styles = require('colorbuddy').setup {}
-- require('noirbuddy').setup {
--   preset = 'kiwi',
--     styles = {
--         italic = true,
--         bold = true,
--     },
--     colors = { -- tsoding color scheme
--         secondary = '#f6de42',
--         -- primary = '#6B9B48',
--         primary = '#74c83b',
--         background = '#181818',
--         noir_0 = '#b3bbc1',
--         noir_1 = '#b3bbc1',
--         noir_2 = '#b3bbc1',
--     }
-- }
-- -- Require colorbuddy...
-- Group.new('@comment', colors.noir_6, nil, styles.italic)
-- Group.new('@constant', colors.secondary, nil)
-- Group.new('@conditional', colors.secondary, nil, styles.bold)
-- Group.new('@repeat', colors.secondary, nil, styles.bold)
-- Group.new('@exception', colors.secondary, nil, styles.bold)
-- Group.new('DiagnosticInfo', colors.diagnostic_info, nil, styles.italic)
-- Group.new('DiagnosticHint', colors.noir_8, nil, styles.italic)
-- Group.new('DiagnosticWarn', colors.diagnostic_warning, nil, styles.italic)
-- Group.new('DiagnosticError', colors.diagnostic_error, nil, styles.italic)

-- -- Hide the characters in FloatBorder
-- vim.api.nvim_set_hl(0, 'FloatBorder', {
--   fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
--   bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
-- })

-- -- Make the StatusLineNonText background the same as StatusLine
-- vim.api.nvim_set_hl(0, 'StatusLineNonText', {
--   fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
--   bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
-- })

-- -- Hide the characters in CursorLineBg
-- vim.api.nvim_set_hl(0, 'CursorLineBg', {
--   fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
--   bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
-- })

-- vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })
-- vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
-- END OF NOIRBUDDY SETTINGS


-- transaprent window
 --vim.cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
 --vim.cmd "let &fcs='eob: '"
