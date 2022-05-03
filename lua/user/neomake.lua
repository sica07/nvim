vim.cmd [[

autocmd BufWritePost * Neomake
let g:neomake_error_sign   = {'text': '☠', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '⚠', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
"
"will not open the quickfix list
"let g:neomake_open_list = 1
let g:neomake_virtualtext_prefix = '➤ '
"will only place signs
let g:neomake_highlight_lines=0

" When writing a buffer (no delay).
"call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
"call neomake#configure#automake('nrwi', 500)

   let args = ['--report=csv', '-q']

    "Add standard argument if one is set.
"let g:neomake_php_phpcs_args_standard=['--report=csv', '-q', '--standard=phpcs_ruleset.xml']
let dir = finddir('.git/..', expand('%:p:h').';')
"let g:neomake_php_phpcs_extra_args = '--standard=' . dir . '/phpcs_ruleset.xml'
let g:neomake_php_phpcs_args_standard= dir . '/phpcs_ruleset.xml'

"let g:neomake_php_phpmd_maker = {
"    \ 'args': ['%t', 'text', '~/Templates/phpmd.xml'],
"    \ 'append_file' : 0,
"    \ 'errorformat': '%W%f:%l%\s%\s%#%m',
"    \ }

let g:neomake_php_psalm_maker = {
    \ 'args': ['--output-format=pylint', '--diff'],
    \ 'errorformat': '%A%f:%l:%\s[%t%n]%\s%m',
    \ }


"let g:neomake_verbose = 3
let g:neomake_php_enabled_makers = ['phpcs', 'psalm']

]]
