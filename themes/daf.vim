
" rafi-2017 - hybrid custom
" =========================

" gVim Appearance {{{
" ---------------------------------------------------------
if has('gui_running')
	set guifont=PragmataPro:h16
	" set noantialias
endif
" }}}

" UI elements {{{
" ---------------------------------------------------------
set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

" icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
" }}}

" Tabline {{{
" ---------------------------------------------------------
" TabLineFill: Tab pages line, where there are no labels
hi TabLineFill ctermfg=234 ctermbg=236 guifg=#1C1C1C guibg=#303030 cterm=NONE gui=NONE
" TabLine: Not-active tab page label
hi TabLine     ctermfg=243 ctermbg=236 guifg=#767676 guibg=#303030 cterm=NONE gui=NONE
" TabLineSel: Active tab page label
hi TabLineSel  ctermfg=241 ctermbg=234 guifg=#626262 guibg=#1C1C1C cterm=NONE gui=NONE
" Custom
highlight TabLineSelShade  ctermfg=235 ctermbg=234 guifg=#262626 guibg=#1C1C1C
highlight TabLineAlt       ctermfg=252 ctermbg=238 guifg=#D0D0D0 guibg=#444444
highlight TabLineAltShade  ctermfg=238 ctermbg=236 guifg=#444444 guibg=#303030

function! Tabline() abort "{{{
	" Active project tab
	let s:tabline =
		\ '%#TabLineAlt# %{badge#project()} '.
		\ '%#TabLineAltShade#┆'.
		\ '%#TabLineFill#  '

	let nr = tabpagenr()
	for i in range(tabpagenr('$'))
		if i + 1 == nr
			" Active tab
			let s:tabline .=
				\ '%#TabLineSelShade#░%#TabLineSel#'.
				\ '%'.(i+1).'T%{badge#label('.(i+1).', "⟪", "N/A")} '.
				\ '%#TabLineFill# '
		else
			" Normal tab
			let s:tabline .=
				\ '%#TabLine# '.
				\ '%'.(i+1).'T%{badge#label('.(i+1).', "┆", "N/A")} '.
				\ '┊ '
		endif
	endfor
	" Empty space and session indicator
	let s:tabline .=
		\ '%#TabLineFill#%T%=%#TabLine#%{badge#session("['.fnamemodify(v:this_session, ':t:r').']")}'
	return s:tabline
endfunction "}}}

let &tabline='%!Tabline()'
" }}}

" Statusline {{{
let s:stl  = " %7*%{&paste ? '=' : ''}%*"         " Paste symbol
let s:stl .= "%4*%{&readonly ? '' : '#'}%*"       " Modified symbol
let s:stl .= "%6*%{badge#mode('⚠ ', 'Z')}"        " Read-only symbol
let s:stl .= '%*%n'                               " Buffer number
let s:stl .= "%6*%{badge#modified('+')}%0*"       " Write symbol
let s:stl .= ' %1*%{badge#filename()}%*'          " Filename
let s:stl .= ' %<'                                " Truncate here
let s:stl .= '%( %{badge#branch()} %)'           " Git branch name
let s:stl .= "%4*%(%{badge#trails('⤐ %s')} %)"  " Whitespace
let s:stl .= '%(%{badge#syntax()} %)%*'           " syntax check
let s:stl .= '%='                                 " Align to right
let s:stl .= '%{badge#format()} %4*%*'           " File format
let s:stl .= '%( %{&fenc} %)'                     " File encoding
let s:stl .= '%4*%*%( %{&ft} %)'                 " File type
let s:stl .= '%3*%2* %l/%2c%4p%% '               " Line and column
let s:stl .= '%{badge#indexing()}%*'              " Indexing tags indicator

" Non-active Statusline {{{
let s:stl_nc = " %{badge#mode('⚠ ', 'Z')}%n"   " Readonly & buffer
let s:stl_nc .= "%6*%{badge#modified('+')}%*"  " Write symbol
let s:stl_nc .= ' %{badge#filename()}'         " Relative supername
let s:stl_nc .= '%='                           " Align to right
let s:stl_nc .= '%{&ft} '                      " File type
" }}}

" Highlights: Statusline {{{
highlight StatusLine   ctermfg=236 ctermbg=248 guifg=#30302c guibg=#a8a897
highlight StatusLineNC ctermfg=236 ctermbg=242 guifg=#30302c guibg=#666656

" Filepath color
highlight User1 guifg=#D7D7BC guibg=#30302c ctermfg=251 ctermbg=236
" Line and column information
highlight User2 guifg=#a8a897 guibg=#4e4e43 ctermfg=248 ctermbg=239
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

let s:disable_statusline =
	\ 'denite\|defx\|tagbar\|nerdtree\|undotree\|diff\|peekaboo\|sidemenu\|color_column'

" Toggle Statusline {{{
augroup statusline
	autocmd!
	autocmd FileType,WinEnter,BufWinEnter,BufReadPost *
		\ if &filetype !~? s:disable_statusline
		\ | let &l:statusline = s:stl
		\ | endif
	autocmd WinLeave *
		\ if &filetype !~? s:disable_statusline
		\ | let &l:statusline = s:stl_nc
		\ | endif
augroup END "}}}

" }}}

" Highlights: General GUI {{{
" ---------------------------------------------------------
" highlight! Error  term=NONE cterm=NONE
" highlight! link WarningMsg  Comment
highlight! link pythonSpaceError  NONE
highlight! link pythonIndentError NONE
" highlight! link mkdLineBreak      NONE
highlight! link ExtraWhitespace  SpellBad
highlight! WarningMsg ctermfg=100 guifg=#CCC566
" }}}


" Plugin: Defx icons and highlights {{{
" ---------------------------------------------------------
let g:defx_git#indicators = {
    \ 'Modified'  : '•',
    \ 'Staged'    : '✚',
    \ 'Untracked' : 'ᵁ',
		\ 'Renamed'   : '≫',
		\ 'Unmerged'  : '≠',
		\ 'Ignored'   : 'ⁱ',
		\ 'Deleted'   : '✖',
		\ 'Unknown'   : '⁇'
	\ }

highlight Defx_filename_3_Modified  ctermfg=1  guifg=#D370A3
highlight Defx_filename_3_Staged    ctermfg=10 guifg=#A3D572
highlight Defx_filename_3_Ignored   ctermfg=8  guifg=#404660
highlight def link Defx_filename_3_Untracked Comment
highlight def link Defx_filename_3_Unknown Comment
highlight def link Defx_filename_3_Renamed Title
highlight def link Defx_filename_3_Unmerged Label
" highlight Defx_git_Deleted   ctermfg=13 guifg=#b294bb

" Plugin: NERDTree icons and highlights {{{
" ---------------------------------------------------------
let g:NERDTreeIndicatorMapCustom = {
	\ 'Modified':  '·',
	\ 'Staged':    '‧',
	\ 'Untracked': '?',
	\ 'Renamed':   '≫',
	\ 'Unmerged':  '≠',
	\ 'Deleted':   '✃',
	\ 'Dirty':     '⁖',
	\ 'Clean':     '✓',
	\ 'Unknown':   '⁇'
	\ }

let g:NERDTreeDirArrowExpandable = '▷'
let g:NERDTreeDirArrowCollapsible = '▼'

highlight! NERDTreeOpenable ctermfg=132 guifg=#B05E87
highlight! def link NERDTreeClosable NERDTreeOpenable

highlight! NERDTreeFile ctermfg=246 guifg=#999999
highlight! NERDTreeExecFile ctermfg=246 guifg=#999999

highlight! clear NERDTreeFlags
highlight! NERDTreeFlags ctermfg=234 guifg=#1d1f21
highlight! NERDTreeCWD ctermfg=240 guifg=#777777

highlight! NERDTreeGitStatusModified ctermfg=1 guifg=#D370A3
highlight! NERDTreeGitStatusStaged ctermfg=10 guifg=#A3D572
highlight! NERDTreeGitStatusUntracked ctermfg=12 guifg=#98CBFE
highlight! def link NERDTreeGitStatusRenamed Title
highlight! def link NERDTreeGitStatusUnmerged Label
highlight! def link NERDTreeGitStatusDirDirty Constant
highlight! def link NERDTreeGitStatusDirClean DiffAdd
highlight! def link NERDTreeGitStatusUnknown Comment

function! s:NERDTreeHighlight()
	for l:name in keys(g:NERDTreeIndicatorMapCustom)
		let l:icon = g:NERDTreeIndicatorMapCustom[l:name]
		if empty(l:icon)
			continue
		endif
		let l:prefix = index(['Dirty', 'Clean'], l:name) > -1 ? 'Dir' : ''
		let l:hiname = escape('NERDTreeGitStatus'.l:prefix.l:name, '~')
		execute 'syntax match '.l:hiname.' #'.l:icon.'# containedin=NERDTreeFlags'
	endfor

	syntax match hideBracketsInNerdTree "\]" contained conceal containedin=NERDTreeFlags
	syntax match hideBracketsInNerdTree "\[" contained conceal containedin=NERDTreeFlags
	" setlocal conceallevel=3
	" setlocal concealcursor=nvic
endfunction

augroup nerdtree-highlights
	autocmd!
	autocmd FileType nerdtree call s:NERDTreeHighlight()
augroup END
"}}}

" Plugin: Tagbar icons {{{
" ---------------------------------------------------------
let g:tagbar_iconchars = ['▷', '◢']
"}}}

" Plugin: Neomake icons {{{
" ---------------------------------------------------------
let g:neomake_error_sign = {'text': '⚠', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '⌁', 'texthl': 'WarningSyntax'}
let g:neomake_message_sign = {'text': '⌂', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': '⊹', 'texthl': 'NeomakeInfoSign'}
"}}}
highlight! WarningSyntax ctermfg=58 guifg=#7d7629

" Plugin: GitGutter icons {{{
" ---------------------------------------------------------
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
"}}}

" Plugin: vim-gitgutter {{{
" ---------------------------------------------------------
highlight! GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
highlight! GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
highlight! GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight! GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
" }}}

" Plugin: denite {{{
" ---------------------------------------------------------
highlight! clear WildMenu
highlight! link WildMenu CursorLine
highlight! link deniteSelectedLine Type
highlight! link deniteMatchedChar Function
highlight! link deniteMatchedRange Underlined
highlight! link deniteMode Comment
highlight! link deniteSource_QuickfixPosition qfLineNr
" }}}

" Plugin: vim-operator-flashy {{{
" ---------------------------------------------------------
highlight! link Flashy DiffText
" }}}

" Plugin: vim-bookmarks {{{
" let g:bookmark_sign = '⚐'
" highlight! BookmarkSign            ctermfg=12 guifg=#4EA9D7
" highlight! BookmarkAnnotationSign  ctermfg=11 guifg=#EACF49
" }}}

" Plugin: vim-choosewin {{{
" ---------------------------------------------------------
let g:choosewin_label = 'SDFJKLZXCV'
let g:choosewin_overlay_enable = 1
let g:choosewin_statusline_replace = 1
let g:choosewin_overlay_clear_multibyte = 0
let g:choosewin_blink_on_land = 0

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

hi LineNr guifg=#969696
hi Normal guibg=NONE ctermbg=NONE
hi ColorColumn guibg=#464849 ctermbg=None

hi CursorLine   cterm=NONE guibg=#464849
hi Visual  guifg=None guibg=#808281 gui=none

let g:airline_powerline_fonts = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes = '\vnotes|help|markdown|rst|org|text|asciidoc|tex|mail'
let g:airline_theme='lucius'


" function! Artify_active_tab_num(n) abort"{{{
"     return Artify(a:n, 'bold')." \ue0bb"
" endfunction"}}}
" function! Artify_inactive_tab_num(n) abort"{{{
"     return Artify(a:n, 'double_struck')." \ue0bb"
" endfunction"}}}
" function! Artify_lightline_tab_filename(s) abort"{{{
"     return Artify(lightline#tab#filename(a:s), 'monospace')
" endfunction"}}}
" function! Artify_lightline_mode() abort"{{{
"     return Artify(lightline#mode(), 'monospace')
" endfunction"}}}
" function! Artify_line_percent() abort"{{{
"     return Artify(string((100*line('.'))/line('$')), 'bold')
" endfunction"}}}
" function! Artify_line_num() abort"{{{
"     return Artify(string(line('.')), 'bold')
" endfunction"}}}
" function! Artify_col_num() abort"{{{
"     return Artify(string(getcurpos()[2]), 'bold')
" endfunction"}}}
" function! Artify_gitbranch() abort"{{{
"     if gitbranch#name() !=# ''
"         return Artify(gitbranch#name(), 'monospace')." \ue725"
"     else
"         return "\ue61b"
"     endif
" endfunction"}}}
" let g:lightline = {}
" let g:lightline.colorscheme = 'forest_night'" let g:airline#extensions#tabline#enabled = 1

" augroup Lightline_Au
"     autocmd!
"     autocmd BufWritePost * call lightline_gitdiff#query_git() | call lightline#update()
" augroup END
" let g:lightline = {}
" let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
" let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
" let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
" let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
" let g:lightline#neomake#prefix_infos = 'ℹ'
" let g:lightline#neomake#prefix_warnings = "\uf529"
" let g:lightline#neomake#prefix_errors = "\uf00d"
" let g:lightline#neomake#prefix_ok = "\uf00c"
" let g:lightline_neomake#format = '%s: %d'
" let g:lightline_neomake#sep = "\ue0b9"
" let g:lightline#lsc#indicator_checking = "\uf110"
" let g:lightline#lsc#indicator_notstarted = "\ufbab"
" let g:lightline#lsc#indicator_errors = "\uf00d"
" let g:lightline#lsc#indicator_ok = "\uf00c"
" let g:lightline#ale#indicator_checking = "\uf110"
" let g:lightline#ale#indicator_warnings = "\uf529"
" let g:lightline#ale#indicator_errors = "\uf00d"
" let g:lightline#ale#indicator_ok = "\uf00c"
" let g:lightline_gitdiff#indicator_added = '+'
" let g:lightline_gitdiff#indicator_deleted = '-'
" let g:lightline_gitdiff#indicator_modified = '*'
" let g:lightline_gitdiff#min_winwidth = '70'
" if g:VIM_Is_In_Tmux == 1
"     let g:Lightline_StatusIndicators = [ 'obsession', 'tmuxlock' ]
" elseif g:VIM_Is_In_Tmux == 0
" endif
" if g:VIM_Linter ==# 'ale'
"     let g:Lightline_Linter = [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]
" elseif g:VIM_Linter ==# 'neomake'
"     let g:Lightline_Linter = [ 'neomake_warnings', 'neomake_errors', 'neomake_infos', 'neomake_ok', 'lsc_ok', 'lsc_errors', 'lsc_checking', 'lsc_warnings' ]
" endif
" let g:lightline.active = {
"            \ 'left': [ [ 'artify_mode', 'paste' ],
"            \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
"            \ 'right': [ [ 'artify_lineinfo' ],
"            \           [ 'asyncrun_status' ] ]
"            \ }
" let g:lightline.inactive = {
"            \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
"            \ 'right': [ [ 'artify_lineinfo' ] ]
"            \ }
" let g:lightline.tabline = {
"            \ 'left': [ [ 'vim_logo', 'tabs' ] ],
"            \ 'right': [ [ 'artify_gitbranch' ],
"            \ [ 'gitstatus' ] ]
"            \ }
" let g:lightline.tab = {
"            \ 'active': [ 'artify_activetabnum', 'artify_filename', 'modified' ],
"            \ 'inactive': [ 'artify_inactivetabnum', 'filename', 'modified' ] }
" let g:lightline.tab_component = {
"            \ }
" let g:lightline.tab_component_function = {
"            \ 'artify_activetabnum': 'Artify_active_tab_num',
"            \ 'artify_inactivetabnum': 'Artify_inactive_tab_num',
"            \ 'artify_filename': 'Artify_lightline_tab_filename',
"            \ 'filename': 'lightline#tab#filename',
"            \ 'modified': 'lightline#tab#modified',
"            \ 'readonly': 'lightline#tab#readonly',
"            \ 'tabnum': 'lightline#tab#tabnum'
"            \ }
" let g:lightline.component = {
"            \ 'artify_gitbranch' : '%{Artify_gitbranch()}',
"            \ 'gitstatus' : '%{lightline_gitdiff#get_status()}',
"            \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
"            \ 'tmuxlock': '%{TmuxBindLock()}',
"            \ 'vim_logo': "\ue7c5",
"            \ 'nicewinnumber': '%{NegativeCircledNumber(tabpagewinnr(tabpagenr()))}',
"            \ 'mode': '%{lightline#mode()}',
"            \ 'artify_mode': '%{Artify_lightline_mode()}',
"            \ 'absolutepath': '%F',
"            \ 'relativepath': '%f',
"            \ 'filename': '%t',
"            \ 'filesize': "%{HumanSize(line2byte('$') + len(getline('$')))}",
"            \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
"            \ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
"            \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
"            \ 'modified': '%M',
"            \ 'bufnum': '%n',
"            \ 'paste': '%{&paste?"PASTE":""}',
"            \ 'readonly': '%R',
"            \ 'charvalue': '%b',
"            \ 'charvaluehex': '%B',
"            \ 'percent': '%2p%%',
"            \ 'percentwin': '%P',
"            \ 'spell': '%{&spell?&spelllang:""}',
"            \ 'lineinfo': '%2p%% %3l:%-2v',
"            \ 'artify_lineinfo': "%2{Artify_line_percent()}\uf295 %3{Artify_line_num()}:%-2{Artify_col_num()}",
"            \ 'line': '%l',
"            \ 'column': '%c',
"            \ 'close': '%999X X ',
"            \ 'winnr': '%{winnr()}'
"            \ }
" let g:lightline.component_function = {
"            \ 'gitbranch': 'gitbranch#name',
"            \ 'devicons_filetype': 'Devicons_Filetype',
"            \ 'devicons_fileformat': 'Devicons_Fileformat'
"            \ }
" let g:lightline.component_expand = {
"            \ 'neomake_infos': 'lightline#neomake#infos',
"            \ 'neomake_warnings': 'lightline#neomake#warnings',
"            \ 'neomake_errors': 'lightline#neomke#errors',
"            \ 'neomake_ok': 'lightline#neomake#ok',
"            \ 'lsc_checking': 'lightline#lsc#checking',
"            \ 'lsc_warnings': 'lightline#lsc#warnings',
"            \ 'lsc_errors': 'lightline#lsc#errors',
"            \ 'lsc_ok': 'lightline#lsc#ok',
"            \ 'linter_checking': 'lightline#ale#checking',
"            \ 'linter_warnings': 'lightline#ale#warnings',
"            \ 'linter_errors': 'lightline#ale#errors',
"            \ 'linter_ok': 'lightline#ale#ok',
"            \ 'asyncrun_status': 'lightline#asyncrun#status'
"            \ }
" let g:lightline.component_type = {
"            \ 'neomake_warnings': 'warning',
"            \ 'neomake_errors': 'error',
"            \ 'neomake_ok': 'middle',
"            \ 'lsc_checking': 'middle',
"            \ 'lsc_warnings': 'warning',
"            \ 'lsc_errors': 'error',
"            \ 'lsc_ok': 'middle',
"            \ 'linter_checking': 'middle',
"            \ 'linter_warnings': 'warning',
"            \ 'linter_errors': 'error',
"            \ 'linter_ok': 'middle'
"            \ }
" let g:lightline.component_visible_condition = {
"            \     'gitstatus': 'lightline_gitdiff#get_status() !=# ""'
"            \   }
" "}}}
"

" vim: set foldmethod=marker ts=2 sw=0 tw=80 noet :
