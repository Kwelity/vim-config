
" Theme
" -----

" Enable 256 color terminal
set t_Co=256

" Enable true color
if has('termguicolors')
	set termguicolors
endif

if has('gui_running')
	set background=dark
	set lines=40
	set columns=150
endif

function! s:theme_reload(name)
	let theme_path = $VIMPATH.'/themes/'.a:name.'.vim'
	if filereadable(theme_path)
		execute 'source' fnameescape(theme_path)
		" Persist theme
		call writefile([g:colors_name], s:cache)
	endif
endfunction

augroup aug_color_scheme
  au!

  " autocmd ColorScheme hybrid call s:PatchColorScheme()
  autocmd ColorScheme forest-night call s:PatchColorScheme()
augroup END

function s:PatchColorScheme()
  hi! link DiffChange NONE
  hi! clear DiffChange
  hi! DiffText term=NONE ctermfg=215 ctermbg=233 cterm=NONE guifg=#FFB86C guibg=#14141a gui=NONE
endfunction

" THEME NAME
let g:theme_name = 'daf-2019'
autocmd MyAutoCmd ColorScheme * call s:theme_reload(g:theme_name)

" COLORSCHEME NAME
let s:cache = $VARPATH.'/theme.txt'
if ! exists('g:colors_name')
	set background=dark
	execute 'colorscheme'
		"\ filereadable(s:cache) ? readfile(s:cache)[0] : 'hybrid'
		\ filereadable(s:cache) ? readfile(s:cache)[0] : 'forest-night'
endif

" vim: set ts=2 sw=2 tw=80 noet :
