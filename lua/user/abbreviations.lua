vim.cmd [[
  :iabbrev <expr> @d strftime('%Y-%m-%d')

  autocmd Filetype javascript :iabbrev @l console.log();<left>
  autocmd Filetype php :iabbrev @l echo "<pre style='border: 1px solid #000; height: 9em; overflow: auto; margin: 0.5em;'>";var_dump();echo "</pre>\n"; <esc>F)i
]]
