" Key-mappings
" ===

" Non-standard {{{
" ---

" Window-control prefix
nnoremap  [Window]   <Nop>
nmap      s [Window]

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
	nnoremap <Up>    :resize +2<CR>
	nnoremap <Down>  :resize -2<CR>
	nnoremap <Left>  :vertical resize +2<CR>
	nnoremap <Right> :vertical resize -2<CR>
endif

" Double leader key for toggling visual-line mode
nmap <silent> <Leader><Leader> V
vmap <Leader><Leader> <Esc>

" Change current word in a repeatable manner
nnoremap <leader>cn *``cgn
nnoremap <leader>cN *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> <leader>cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> <leader>cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

nnoremap <leader>cp yap<S-}>p
nnoremap <leader>a =ip

" xnoremap p  "0p
" nnoremap x "_x

" Toggle fold
nnoremap <CR> za

" Focus the current fold by closing all others
nnoremap <S-Return> zMza

" Use backspace key for matchit.vim
nmap <BS> %
xmap <BS> %

"}}}
" Global niceties {{{
" ---------------

" Start an external command with a single bang
nnoremap ! :!

" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Q q
cnoreabbrev Bd bd
cnoreabbrev bD bd

" Start new line from any cursor position
inoremap <S-Return> <C-o>o

nnoremap zl z5l
nnoremap zh z5h

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
	\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "5\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "5\<C-y>")

" Window control
nnoremap <C-q> <C-w>
" nnoremap <C-x> <C-w>x<C-w>w
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv
" nmap >>  >>_
" nmap <<  <<_

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Navigation in command line
" cnoremap <C-h> <Home>
cnoremap <C-l> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <C-w>


" Switch history search pairs, matching my bash shell
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>

" Fuzzy search
map z/ <Plug>(incsearch-fuzzy-/)
map <silent><Space>/ <Plug>(incsearch-fuzzy-/)

" }}}
" File operations {{{
" ---------------

" Switch to the directory of the opened buffer
map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" Fast saving
nnoremap <silent><Leader>w :write<CR>
nnoremap <silent><Leader>ww :write!<CR>
vnoremap <silent><Leader>w <Esc>:write<CR>
nnoremap <silent><C-s> :<C-u>write<CR>
vnoremap <silent><C-s> :<C-u>write<CR>
cnoremap <silent><C-s> <C-u>write<CR>

" }}}
" Editor UI {{{
" ---------

" I like to :quit with 'q', shrug.
nnoremap <silent> q :<C-u>:quit<CR>

" Macros
nnoremap Q q
nnoremap gQ @q

" Show vim syntax highlight groups for character under cursor
nmap <silent> gh :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
	\.'> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name').'> lo<'
	\.synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name').'>'<CR>

" Toggle editor visuals
nmap <silent> <Leader>ts :setlocal spell!<cr>
nmap <silent> <Leader>tn :setlocal nonumber!<CR>
nmap <silent> <Leader>tN :setlocal number relativenumber!<CR>
nmap <silent> <Leader>tl :setlocal nolist!<CR>
nmap <silent> <Leader>th :nohlsearch<CR>
nmap <silent> <Leader>tw :setlocal wrap! breakindent!<CR>

" Tabs
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g$ :<C-u>tablast<CR>
nnoremap <silent> gr :<C-u>tabprevious<CR>
nnoremap <silent> gt :<C-u>tabnext<CR>
nnoremap <silent> <A-j> :<C-U>tabnext<CR>
nnoremap <silent> <A-k> :<C-U>tabprevious<CR>
nnoremap <silent> <C-Tab> :<C-U>tabnext<CR>
nnoremap <silent> <C-S-Tab> :<C-U>tabprevious<CR>
" Uses g:lasttab set on TabLeave in MyAutoCmd
let g:lasttab = 1
nmap <silent> \\ :execute 'tabn '.g:lasttab<CR>

" Splits

" Remap to use Alt for panes nav for better intergration with tmux
map <A-j> <C-j>
map <A-k> <C-k>
map <A-l> <C-l>
map <A-h> <C-h>

" Remap C-W to Leader-W for pane manipulation
nnoremap <Leader>z <C-w>

" zoom panels
nnoremap <Leader>z. <C-w>5>
nnoremap <Leader>z, <C-w>5<
nnoremap <Leader>z> <C-w>25>
nnoremap <Leader>z< <C-w>25<
noremap <Leader>z <c-w>_ \| <c-w>\|
noremap <Leader>zz <c-w>=

au! WinEnter * call SetWinAdjust()
function! SetWinAdjust()
   if winnr() > 1
      nnoremap <Leader>zh <C-w>10>
      nnoremap <Leader>zH <C-w>50>
      nnoremap <Leader>zj <C-w>10-
      nnoremap <Leader>zk <C-w>10+
      nnoremap <Leader>zl <C-w>10<
      nnoremap <Leader>zL <C-w>50<
      nnoremap <C-Right> <C-w><
      nnoremap <C-Left> <C-w>>
   else
      nnoremap <Leader>zh <C-w>10<
      nnoremap <Leader>zH <C-w>50<
      nnoremap <Leader>zj <C-w>10+
      nnoremap <Leader>zk <C-w>10-
      nnoremap <Leader>zl <C-w>10>
      nnoremap <Leader>zL <C-w>50>
      nnoremap <C-Right> <C-w>>
      nnoremap <C-Left> <C-w><
   endif
 endfunction

let t:is_transparent = 1
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        hi Normal guibg=#191a1c ctermbg=NONE
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

" }}}
" Totally Custom {{{
" --------------

" remap _ to blackhole register
nnoremap _ "_

" clear all global registers
function! s:clear_registers()
	let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', '\zs')
	for r in regs
		call setreg(r, [])
	endfor
endfunction

command! ClearRegisters :call s:clear_registers()

" remap decrease number to A-a
" nnoremap <A-a> <C-x>

" Add new lines
" nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
" nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Remove spaces at the end of lines
nnoremap <silent> <Leader>cw :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" C-r: Easier search and replace
xnoremap <C-r> :<C-u>call <SID>get_selection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>

" Quick substitute within selected area
xnoremap sg :s//gc<Left><Left><Left>

" Returns visually selected text
function! s:get_selection(cmdtype) "{{{
	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}

" Location/quickfix list movement
nmap ]c :lnext<CR>
nmap [c :lprev<CR>
nmap ]q :cnext<CR>
nmap [q :cprev<CR>

" Duplicate lines
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv

" Source line and selection in vim
vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" Yank buffer's absolute path to clipboard
nnoremap <Leader>y :let @+=expand("%")<CR>:echo 'Yanked relative path'<CR>
nnoremap <Leader>Y :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>

" Drag current line/s vertically and auto-indent
vnoremap <Leader>k :m-2<CR>gv=gv
vnoremap <Leader>j :m'>+<CR>gv=gv
noremap  <Leader>k :m-2<CR>
noremap  <Leader>j :m+<CR>

" Move visual block
vnoremap J :m'>+<CR>gv=gv
vnoremap K :m-2<CR>gv=gv

" Context-aware action-menu, neovim only (see plugin/actionmenu.vim)
if has('nvim')
	nmap <silent> <LocalLeader>c :<C-u>ActionMenu<CR>
endif

" Session management shortcuts (see plugin/sessions.vim)
nmap <silent> <Leader>se :<C-u>SessionSave<CR>
nmap <silent> <Leader>os :<C-u>SessionLoad<CR>

if has('mac')
	" Open the macOS dictionary on current word
	nmap <Leader>? :!open dict://<cword><CR><CR>

	" Use Marked for real-time Markdown preview
	"
	if executable('/Applications/Marked 2.app/Contents/MacOS/Marked 2')
		autocmd user_events FileType markdown
			\ nmap <buffer><Leader>P :silent !open -a Marked\ 2.app '%:p'<CR>
	endif
endif

" }}}
" Append modeline to EOF {{{
nnoremap <silent> <Leader>ml :call <SID>append_modeline()<CR>

" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() "{{{
	let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction "}}}

" }}}
" Windows and buffers {{{

nnoremap <silent> [Window]v  :<C-u>split<CR>
nnoremap <silent> [Window]g  :<C-u>vsplit<CR>
nnoremap <silent> [Window]t  :tabnew<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]b  :b#<CR>
nnoremap <silent> [Window]c  :close<CR>
nnoremap <silent> [Window]x  :<C-u>call <SID>window_empty_buffer()<CR>

" Split current buffer, go to previous window and previous buffer
nnoremap <silent> [Window]sv :split<CR>:wincmd p<CR>:e#<CR>
nnoremap <silent> [Window]sg :vsplit<CR>:wincmd p<CR>:e#<CR>

" Background dark/light toggle and contrasts
nmap <silent> [Window]h :<C-u>call <SID>toggle_background()<CR>
nmap <silent> [Window]- :<c-u>call <SID>toggle_contrast(-v:count1)<cr>
nmap <silent> [Window]= :<c-u>call <SID>toggle_contrast(+v:count1)<cr>

function! s:toggle_background()
	if ! exists('g:colors_name')
		echomsg 'No colorscheme set'
		return
	endif
	let l:scheme = g:colors_name

	if l:scheme =~# 'dark' || l:scheme =~# 'light'
		" Rotate between different theme backgrounds
		execute 'colorscheme' (l:scheme =~# 'dark'
					\ ? substitute(l:scheme, 'dark', 'light', '')
					\ : substitute(l:scheme, 'light', 'dark', ''))
	else
		execute 'set background='.(&background ==# 'dark' ? 'light' : 'dark')
		if ! exists('g:colors_name')
			execute 'colorscheme' l:scheme
			echomsg 'The colorscheme `'.l:scheme
				\ .'` doesn''t have background variants!'
		else
			echo 'Set colorscheme to '.&background.' mode'
		endif
	endif
endfunction

function! s:toggle_contrast(delta)
	let l:scheme = ''
	if g:colors_name =~# 'solarized8'
		let l:schemes = map(['_low', '_flat', '', '_high'],
			\ '"solarized8_".(&background).v:val')
		let l:contrast = ((a:delta + index(l:schemes, g:colors_name)) % 4 + 4) % 4
		let l:scheme = l:schemes[l:contrast]
	endif
	if l:scheme !=# ''
		execute 'colorscheme' l:scheme
	endif
endfunction

function! s:window_empty_buffer()
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete '.l:current
	endif
endfunction
" }}}

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Jq
command! JsonBeautify %!jq '.'
command! Jq %!jq '.'
" VSCode
command! OpenInVSCode exe "silent !code --goto '" . expand("%") . ":" . line(".") . ":" . col(".") . "'" | redraw!
command! VSCode OpenInVSCode
command! Code OpenInVSCode

" Denite
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
