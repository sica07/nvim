vim.cmd [[
  :iabbrev <expr> @d strftime('%Y-%m-%d')

  autocmd Filetype javascript :iabbrev @l console.log();<left><left>i
  autocmd Filetype php :iabbrev @l var_export();<left><left>i
]]
