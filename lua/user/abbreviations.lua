vim.cmd [[
  :iabbrev <expr> @d strftime('%Y-%m-%d')

  autocmd Filetype javascript :iabbrev @l console.log();<left><left>i

  autocmd Filetype php :iabbrev @l var_dump();<left><left>i
  autocmd Filetype php :iabbrev @d dd();<left><left>i
  autocmd Filetype php :iabbrev @u dump();<left><left>i
  autocmd Filetype php :iabbrev @s <esc>odeclare(strict_types=1);<esc>o<esc>
]]
