require("tokyonight").setup({
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
})
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
