vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    "autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted

    "autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,json,markdown autocmd BufWritePre <buffer> call StripTrailingWhitespace()

    "au BufWritePre * :%s/\s\+$//e "on save remove all trailing spaces
  augroup end

  augroup toggle_relativenumbering
    autocmd!
      au InsertEnter * set norelativenumber
      au InsertLeave * set relativenumber
  augroup end

""  augroup _colorschema
""    autocmd!
""    "for some reasons the autocmds bellow don't work
""    "only the hi! commands work
""    autocmd ColorScheme * hi Folded       cterm=italic gui=italic
""    autocmd ColorScheme * hi Comment      cterm=italic gui=italic
""    autocmd ColorScheme * hi ErrorMsg            ctermbg=1   ctermfg=white
""    autocmd ColorScheme * hi Error               cterm=bold  ctermfg=7 ctermbg=1
""    autocmd ColorScheme * hi diffDelete         ctermfg=1  ctermbg=NONE
""    autocmd ColorScheme * hi diffAdd           ctermfg=10  ctermbg=NONE
""    autocmd ColorScheme * hi diffChange         ctermfg=167 ctermbg=NONE
""    autocmd ColorScheme * hi diffText            ctermfg=32  ctermbg=NONE
""
""    hi! link diffAdded DiffAdd
""    hi! link diffChanged diffChange
""    hi! link diffRemoved diffDelete
""
""  augroup end

  augroup _git
    autocmd!
    autocmd Filetype gitcommit setlocal spell textwidth=72
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  "augroup _markdown
    "autocmd!
  "augroup end

"  augroup _auto_resize
    "autocmd!
    "autocmd VimResized * tabdo wincmd =
  "augroup end

  "augroup _md
    "autocmd!
    "autocmd FileType markdown setlocal wrap
    "autocmd FileType markdown setlocal spell
    " au FileType vimwiki,markdown set background=light |:color paper | set nospell | ZenMode | set signcolumn=no
  "augroup end

  augroup _php
    autocmd!
    "au FileType php setlocal omnifunc=phpactor#Complete
    "au FileType php nmap <buffer> <Leader>,eu :PhpactorImportClass<CR>
    "au FileType php nmap <buffer> <Leader>,ce :PhpactorClassExpand<CR>
    "au FileType php vnoremap <buffer> <Leader>,em :PhpactorExtractMethod<CR>
    "au FileType php nnoremap <buffer> <Leader>,ec :PhpactorExtractConstant<CR>
    "au FileType php nmap <buffer> <Leader>,ic :PhpactorImportMissingClasses<CR>
    "au FileType php nmap <buffer> <Leader>. :PhpactorContextMenu<CR>
    "au FileType php nmap <buffer> <Leader>,nn :PhpactorNavigate<CR>
    "au FileType php,cucumber nmap <buffer> <Leader>.gd
        "\ :PhpactorGotoDefinition edit<CR>
    "au FileType php nmap <buffer> <Leader>,k :PhpactorHover<CR>
    "au FileType php nmap <buffer> <Leader>,cc :PhpactorClassNew<CR>
    "au FileType php nmap <buffer> <Leader>,ci :PhpactorClassInflect<CR>
    "au FileType php nmap <buffer> <Leader>,fr :PhpactorFindReferences<CR>
    "au FileType php nmap <buffer> <Leader>,ep :PhpactorTransform<CR>
    "au FileType php nmap <buffer> <Leader>,mf :PhpactorMoveFile<CR>
    "au FileType php nmap <buffer> <Leader>,cf :PhpactorCopyFile<CR>
    "au FileType php nmap <buffer> <silent> <Leader>,ee
        "\ :PhpactorExtractExpression<CR>
    "au FileType php vmap <buffer> <silent> <Leader>,ee
        "\ :<C-u>PhpactorExtractExpression<CR>
  augroup end

  augroup resCur
      autocmd!
      autocmd BufWinEnter * call ResCur()
  augroup END

" Remove trailing whitespaces and ^M chars
"function! StripTrailingWhitespace()
    "" Preparation: save last search, and cursor position.
    "let _s=@/
    "let l = line(".")
    "let c = col(".")
    "" do the business:
    "%s/\s\+$//e
    "" clean up: restore previous search history, and cursor position
    "let @/=_s
    "call cursor(l, c)
"endfunction

" Restore cursor to file position in previous editing session
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

" Custom conceal
syntax match Statement "^\[x\]" conceal cchar=
syntax match Constant "^\[\ \]" conceal cchar=
syntax match Normal "<=" conceal cchar=≲
syntax match Normal ">=" conceal cchar=≳
syntax match Normal "=>" conceal cchar=⇒
syntax match Normal "\:\:" conceal cchar=∷
syntax match Normal "==" conceal cchar=≡
syntax match Normal "!=" conceal cchar=≠
set cole=2

]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
