
set diffopt=vertical,filler,context:3,indent-heuristic,algorithm:patience,internal

" if has('patch-8.1.0360')
" 	set diffopt+=internal,algorithm:patience
" endif

" Detect if vim is started as a diff tool (vim -d, vimdiff)
" NOTE: Does not work when you start Vim as usual and enter diff mode using :diffthis
if &diff
  let s:is_started_as_vim_diff = 1
  syntax off
  setlocal nospell
endif

augroup aug_diffs
  au!

  " Inspect whether some windows are in diff mode, and apply changes for such windows
  " Run asynchronously, to ensure '&diff' option is properly set by Vim
  au WinEnter,BufEnter * call timer_start(50, 'CheckDiffMode')

augroup END

" In diff mode:
" - Disable syntax highlighting
" - Disable spell checking
function! CheckDiffMode(timer)
  let curwin = winnr()

  " Check each window
  for _win in range(1, winnr('$'))
    exe "noautocmd " . _win . "wincmd w"

    call s:change_option_in_diffmode('b:', 'syntax', 'off')
    call s:change_option_in_diffmode('w:', 'spell', 0, 1)
  endfor

  " Get back to original window
  exe "noautocmd " . curwin . "wincmd w"
endfunction

" Detect window or buffer local option is in sync with diff mode
function s:change_option_in_diffmode(scope, option, value, ...)
  let isBoolean = get(a:, "1", 0)
  let backupVarname = a:scope . "_old_" . a:option

  " Entering diff mode
  if &diff && !exists(backupVarname)
    exe "let " . backupVarname . "=&" . a:option
    call s:set_option(a:option, a:value, 1, isBoolean)
  endif

  " Exiting diff mode
  if !&diff && exists(backupVarname)
    let oldValue = eval(backupVarname)
    call s:set_option(a:option, oldValue, 1, isBoolean)
    exe "unlet " . backupVarname
  endif
endfunction

function s:set_option(option, value, ...)
  let isLocal = get(a:, "1", 0)
  let isBoolean = get(a:, "2", 0)
  if isBoolean
    exe (isLocal ? "setlocal " : "set ") . (a:value ? "" : "no") . a:option
  else
    exe (isLocal ? "setlocal " : "set ") . a:option . "=" . a:value
  endif
endfunction

nnoremap <silent> <leader>q :call <SID>QuitWindow()<CR>

function s:QuitWindow()
  if get(s:, 'is_started_as_vim_diff', 0)
    qall
    return
  endif
	"
    " If we're in merge mode, exit it
    if get(g:, 'mergetool_in_merge_mode', 0)
      call mergetool#stop()
      return
    endif

  quit
endfunction

" possible values: 'local' (default), 'remote', 'base'
let g:mergetool_prefer_revision = 'local'

" (m) - for working tree version of merged file
" (r) - for 'remote' revision
" (l) - for 'local' revision
let g:mergetool_layout = 'bmr'

function s:on_mergetool_set_layout(split)

  " When base is horizontal split at the bottom
  " Turn off diff mode, and show syntax highlighting
  " Also let it take less height
  if a:split["layout"] ==# 'mr,b' && a:split["split"] ==# 'b'
	setlocal nodiff
	setlocal syntax=on
	resize 15
  endif
endfunction

let g:MergetoolSetLayoutCallback = function('s:on_mergetool_set_layout')

nmap <leader>mt <plug>(MergetoolToggle)
nnoremap <silent> <leader>mb :call mergetool#toggle_layout('mr,b')<CR>


nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'
