
" LanguageClient-neovim
" ---

" General settings " {{{
" ---

"let g:LanguageClient_diagnosticsSignsMax=0
let g:LanguageClient_diagnosticsEnable=4
let g:LanguageClient_diagnosticsList="Quickfix"
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_complete_done = 1
let g:LanguageClient_selectionUI = "quickfix"
let g:LanguageClient_fzfContextMenu = 1

let g:LanguageClient_serverCommands = {
  \ 'rust': ['/usr/bin/rustup', 'run', 'stable', 'rls'],
  \ }

" let g:LanguageClient_serverCommands = {
"   \ 'rust': ['~/.cargo/bin/ra_lsp_server'],
"   \ }

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" }}}

" Key-mappings and Events " {{{
" ---

autocmd FileType * call LC_maps()
function! LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
	nnoremap <buffer> <silent> <Leader>i :call LanguageClient#textDocument_hover()<cr>
	nnoremap ,i :call LanguageClient#textDocument_hover()<cr>
	nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
	nnoremap ,d :call LanguageClient#textDocument_definition()<CR>
	nnoremap ,r :call LanguageClient#textDocument_rename()<CR>
	nnoremap ,f :call LanguageClient#textDocument_formatting()<CR>
	nnoremap ,t :call LanguageClient#textDocument_typeDefinition()<CR>
	nnoremap ,x :call LanguageClient#textDocument_references()<CR>
	nnoremap ,c :call LanguageClient#textDocument_codeAction()<CR>
	nnoremap ,h :call LanguageClient#textDocument_hover()<CR>
	nnoremap ,s :call LanguageClient_textDocument_documentSymbol()<CR>
	nnoremap ,m :call LanguageClient_contextMenu()<CR>
	nnoremap ,, :call LanguageClient_diagnosticsEnable()<CR>
    endif
endfunction

" }}}
