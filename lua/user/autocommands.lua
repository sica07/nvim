vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted

    autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,json,markdown autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd FileType c,cpp,java,go,javascript,python,twig,xml,yml,json,markdown autocmd BufWritePre <buffer> call StripTrailingWhitespace()

    au BufWritePre * :%s/\s\+$//e "on save remove all trailing spaces
  augroup end

  augroup _git
    autocmd!
    autocmd Filetype gitcommit setlocal spell textwidth=72
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _php
    autocmd!
    autocmd FileType php setlocal omnifunc=phpactor#Complete
    au FileType php nmap <buffer> <Leader>.eu :PhpactorImportClass<CR>
    au FileType php nmap <buffer> <Leader>e :PhpactorClassExpand<CR>
    au FileType php vnoremap <buffer> <Leader>.em :PhpactorExtractMethod<CR>
    au FileType php nnoremap <buffer> <Leader>.ec :PhpactorExtractConstant<CR>
    au FileType php nmap <buffer> <Leader>.ic :PhpactorImportMissingClasses<CR>
    au FileType php nmap <buffer> <Leader>. :PhpactorContextMenu<CR>
    au FileType php nmap <buffer> <Leader>.nn :PhpactorNavigate<CR>
    au FileType php,cucumber nmap <buffer> <Leader>.gd
        \ :PhpactorGotoDefinition edit<CR>
    au FileType php nmap <buffer> <Leader>.k :PhpactorHover<CR>
    au FileType php nmap <buffer> <Leader>.cc :PhpactorClassNew<CR>
    au FileType php nmap <buffer> <Leader>.ci :PhpactorClassInflect<CR>
    au FileType php nmap <buffer> <Leader>.fr :PhpactorFindReferences<CR>
    au FileType php nmap <buffer> <Leader>.ep :PhpactorTransform<CR>
    au FileType php nmap <buffer> <Leader>.mf :PhpactorMoveFile<CR>
    au FileType php nmap <buffer> <Leader>.cf :PhpactorCopyFile<CR>
    au FileType php nmap <buffer> <silent> <Leader>.ee
        \ :PhpactorExtractExpression<CR>
    au FileType php vmap <buffer> <silent> <Leader>.ee
        \ :<C-u>PhpactorExtractExpression<CR>
  augroup end

  augroup resCur
      autocmd!
      autocmd BufWinEnter * call ResCur()
  augroup END

" Remove trailing whitespaces and ^M chars
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Restore cursor to file position in previous editing session
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
