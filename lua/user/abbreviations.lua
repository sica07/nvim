vim.cmd [[
  :iabbrev <expr> @d strftime('%Y-%m-%d')

  autocmd Filetype javascript :iabbrev @l console.log();<left><left>i

  autocmd Filetype php :iabbrev @l var_dump();<left><left>i
  autocmd Filetype php :iabbrev @dd dd();<left><left>i
  autocmd Filetype php :iabbrev @du dump();<left><left>i
  autocmd Filetype php :iabbrev @s <esc>odeclare(strict_types=1);<esc>o<esc>
  autocmd Filetype php :iabbrev @l var_export();<left><left>i
]]
