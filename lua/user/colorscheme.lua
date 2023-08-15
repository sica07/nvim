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
colorscheme sunbather
" colorscheme everforest
"colorscheme phoenix
"PhoenixGreenEighties
" set background=dark
" colorscheme skull
" colorscheme zenwritten
"colorscheme paramount
set background=light
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
-- Hide the characters in FloatBorder
vim.api.nvim_set_hl(0, 'FloatBorder', {
  fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
  bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
})

-- Make the StatusLineNonText background the same as StatusLine
vim.api.nvim_set_hl(0, 'StatusLineNonText', {
  fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
  bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
})

-- Hide the characters in CursorLineBg
vim.api.nvim_set_hl(0, 'CursorLineBg', {
  fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
  bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
})

vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })
vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
-- transaprent window
 --vim.cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
 --vim.cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
 --vim.cmd "let &fcs='eob: '"
