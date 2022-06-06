vim.cmd [[
try
  " colorscheme phoenix
  " PhoenixGreenEighties
  set background=dark
  " colorscheme skull
  colorscheme zenwritten
  " set background=light
  " colorscheme zenbones
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
  set background=dark
endtry
]]
