vim.g.tokyonight_transparent=true
vim.g.tokyonight_transparent_sidebar=true
vim.g.tokyonight_style="dark"
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
vim.g.tokyonight_hide_inactive_status_line = true
vim.cmd [[
try
  " colorscheme phoenix
  " PhoenixGreenEighties
  set background=dark
  " colorscheme skull
  " colorscheme zenwritten
  colorscheme tokyonight
  " set background=light
  " colorscheme zenbones
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
  set background=dark
endtry
]]

-- transaprent window
-- vim.cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
-- vim.cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
-- vim.cmd "let &fcs='eob: '"
