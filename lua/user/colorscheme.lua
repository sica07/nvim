vim.cmd [[
try
  colorscheme phoenix
  PhoenixGreenEighties
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
