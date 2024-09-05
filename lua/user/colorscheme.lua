vim.cmd [[
try
" colorscheme paper
"colorscheme sunbather
"colorscheme nord
colorscheme catppuccin-frappe
"colorscheme noirbuddy
set background=light
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

au ColorScheme * hi! Keyword gui=bold
au ColorScheme * hi! Comment gui=italic
"highlight Comment guifg=#bbbbbb
"highlight Constant guifg=#999999
highlight NormalFloat guibg=#eeeeee
"colorscheme quiet
colorscheme paper
endtry
]]
