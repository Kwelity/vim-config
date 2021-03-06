
" hybrid custom
" ===

" gVim Appearance {{{
" ---
if has('gui_running')
	set guifont=PragmataPro:h16
	set guioptions=Mc
	" set noantialias
endif
" }}}


highlight Normal guibg=None ctermbg=None
highlight Visual  guifg=None guibg=#a35959 gui=None
highlight CursorLine  guifg=None guibg=#464b51 gui=None

" Terminal colors {{{
" ---
let g:terminal_color_0 = '#2a2a2a'
let g:terminal_color_1 = '#d370a3'
let g:terminal_color_2 = '#6d9e3f'
let g:terminal_color_3 = '#b58858'
let g:terminal_color_4 = '#6095c5'
let g:terminal_color_5 = '#ac7bde'
let g:terminal_color_6 = '#3ba275'
let g:terminal_color_7 = '#ffffff'
let g:terminal_color_8 = '#686868'
let g:terminal_color_9 = '#ffa7da'
let g:terminal_color_10 = '#a3d572'
let g:terminal_color_11 = '#efbd8b'
let g:terminal_color_12 = '#98cbfe'
let g:terminal_color_13 = '#e5b0ff'
let g:terminal_color_14 = '#75daa9'
let g:terminal_color_15 = '#cfcfcf'
" }}}

" Tabline {{{
" ---
" TabLineFill: Tab pages line, where there are no labels
highlight TabLineFill ctermfg=234 ctermbg=236 guifg=#3a3b3d guibg=#303030 cterm=None gui=None
" TabLine: Not-active tab page label
highlight TabLine     ctermfg=243 ctermbg=236 guifg=#767676 guibg=#303030 cterm=None gui=None
" TabLineSel: Active tab page label
highlight TabLineSel  ctermfg=241 ctermbg=234 guifg=#626262 guibg=#3a3b3d cterm=None gui=None
" Custom
highlight TabLineSelShade  ctermfg=235 ctermbg=234 guifg=#262626 guibg=#3a3b3d
highlight TabLineAlt       ctermfg=252 ctermbg=238 guifg=#D0D0D0 guibg=#3a3b3d
highlight TabLineAltShade  ctermfg=238 ctermbg=236 guifg=#3a3b3d guibg=#303030

highlight ColorColumn ctermfg=241 ctermbg=234 guibg=#3a3b3d ctermbg=None cterm=None
highlight SignColumn guibg=None ctermbg=None
" }}}

" Highlights: Statusline {{{
highlight StatusLine   ctermfg=236 ctermbg=248 guifg=#30302c guibg=#a8a897
highlight StatusLineNC ctermfg=236 ctermbg=242 guifg=#30302c guibg=#666656

" Filepath color
highlight User1 guifg=#D7D7BC guibg=#30302c ctermfg=251 ctermbg=236
" Line and column information
highlight User2 guifg=#a8a897 guibg=#464849 ctermfg=248 ctermbg=239
" Line and column corner arrow
highlight User3 guifg=#4e4e43 guibg=#30302c ctermfg=239 ctermbg=236
" Buffer # symbol and whitespace or syntax errors
highlight User4 guifg=#666656 guibg=#30302c ctermfg=242 ctermbg=236
" Write symbol
highlight User6 guifg=#cf6a4c guibg=#30302c ctermfg=167 ctermbg=236
" Paste symbol
highlight User7 guifg=#99ad6a guibg=#30302c ctermfg=107 ctermbg=236
" Syntax and whitespace
highlight User8 guifg=#ffb964 guibg=#30302c ctermfg=215 ctermbg=236
" }}}

" Highlights: General GUI {{{
" ---
highlight! link jsFutureKeys PreProc
" highlight! Error  term=None cterm=None
highlight! WarningMsg  ctermfg=100 guifg=#CCC566
" Matchparens
highlight! MatchParen  ctermfg=NONE guifg=NONE ctermbg=236 guibg=#30302c


" highlight! link WarningMsg  Comment
" highlight! link pythonSpaceError  None
" highlight! link pythonIndentError None
" highlight! link mkdLineBreak      None
" highlight! WarningMsg ctermfg=100 guifg=#CCC566
" highlight! ParenMatch  ctermbg=236 guibg=#30302c
" highlight! CursorWord0 ctermbg=236 guibg=#30302c
" highlight! CursorWord1 ctermbg=236 guibg=#30302c
" }}}

" Plugin: Defx icons and highlights {{{
" ---
highlight Defx_filename_3_Modified  ctermfg=1  guifg=#D370A3
highlight Defx_filename_3_Staged    ctermfg=10 guifg=#A3D572
highlight Defx_filename_3_Ignored   ctermfg=8  guifg=#404660
highlight link Defx_filename_3_root_marker Comment

highlight def link Defx_filename_3_Untracked Comment
highlight def link Defx_filename_3_Unknown Comment
highlight def link Defx_filename_3_Renamed Title
highlight def link Defx_filename_3_Unmerged Label
" highlight Defx_git_Deleted   ctermfg=13 guifg=#b294bb
" }}}

" Plugin: Neomake icons {{{
" ---
let g:neomake_error_sign = {'text': '⚠', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '⌁', 'texthl': 'WarningSyntax'}
let g:neomake_message_sign = {'text': '⌂', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': '⊹', 'texthl': 'NeomakeInfoSign'}
highlight! WarningSyntax ctermfg=58 guifg=#7d7629
"}}}

" Plugin: vim-gitgutter {{{
" ---
highlight! GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=234 guibg=None
highlight! GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=234 guibg=None
highlight! GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=234 guibg=None
highlight! GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=234 guibg=None
" }}}

" Plugin: denite {{{
" ---
highlight! clear WildMenu
highlight! link WildMenu CursorLine
highlight! link deniteSelectedLine Type
highlight! link deniteMatchedChar Function
highlight! link deniteMatchedRange Underlined
highlight! link deniteMode Comment
highlight! link deniteSource_QuickfixPosition qfLineNr
" }}}

" Plugin: vim-operator-flashy {{{
" ---
highlight! link Flashy DiffText
" }}}

" Plugin: vim-signature {{{
highlight! SignatureMarkText    ctermfg=11 guifg=#756207 ctermbg=234 guibg=#3a3b3d
highlight! SignatureMarkerText  ctermfg=12 guifg=#4EA9D7 ctermbg=234 guibg=#3a3b3d
" }}}

" Plugin: vim-choosewin {{{
" ---
let g:choosewin_color_label = {
	\ 'cterm': [ 236, 2 ], 'gui': [ '#555555', '#000000' ] }
let g:choosewin_color_label_current = {
	\ 'cterm': [ 234, 220 ], 'gui': [ '#333333', '#000000' ] }
let g:choosewin_color_other = {
	\ 'cterm': [ 235, 235 ], 'gui': [ '#333333' ] }
let g:choosewin_color_overlay = {
	\ 'cterm': [ 2, 10 ], 'gui': [ '#88A2A4' ] }
let g:choosewin_color_overlay_current = {
	\ 'cterm': [ 72, 64 ], 'gui': [ '#7BB292' ] }
" }}}

" vim: set foldmethod=marker ts=2 sw=0 tw=80 noet :
