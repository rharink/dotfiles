"" {{{ Plugins
call plug#begin('~/.vim/plugged')
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Dashboard
Plug 'mhinz/vim-startify'
" Autocompeltion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
" Multi cursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Tpope
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive' 
" Typescript
Plug 'peitalin/vim-jsx-typescript' 
Plug 'leafgarland/typescript-vim'
" Colorscheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'
" Misc
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'vimlab/split-term.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vim-which-key'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'ryanoasis/vim-devicons'
Plug 'adelarsq/vim-devicons-emoji'
call plug#end()
" }}}

"" {{{ General
set clipboard+=unnamedplus
set encoding=UTF-8

" Use relative line numbers
set number relativenumber

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Smarter cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" For things that are mark down or text turn on spelling
autocmd FileType md,markdown,txt setlocal spell spelllang=en_us

" Do the same for git commits
autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us

set timeoutlen=500
" }}}

"" {{{ Map Leader
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
" }}}

"" {{{ Backups
" create directory if needed
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
endif

" Backup files
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =

" swap files
set directory   =$HOME/.vim/files/swap/
set updatecount =100

" undo files
set undofile
set undodir     =$HOME/.vim/files/undo/

" viminfo files
set viminfo     ='100,n$HOME/.vim/files/info/viminfo
" }}}

"" {{{ Colorscheme
set termguicolors
set background=dark
colorscheme onehalfdark
let g:lightline = {
      \ 'colorscheme': 'onehalfdark',
      \ }
" }}}

"" {{{ Sneak Plugin
let g:sneak#label = 1
" }}}

"" {{{ FZF Plugin
let g:fzf_layout = { 'down': '~40%' }

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" }}}

"" {{{ Coc Plugin
if !exists('g:vscode')
	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
	      \ pumvisible() ? "\<C-n>" :
	      \ <SID>check_back_space() ? "\<TAB>" :
	      \ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	if has('nvim')
	  inoremap <silent><expr> <c-space> coc#refresh()
	else
	  inoremap <silent><expr> <c-@> coc#refresh()
	endif

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
	if exists('*complete_info')
	  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
	  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
	    execute 'h '.expand('<cword>')
	  else
	    call CocActionAsync('doHover')
	  endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>rf  <Plug>(coc-format-selected)
	nmap <leader>rf  <Plug>(coc-format-selected)

	augroup mygroup
	  autocmd!
	  " Setup formatexpr specified filetype(s).
	  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	  " Update signature help on jump placeholder.
	  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current buffer.
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nmap <leader>rqf  <Plug>(coc-fix-current)

	" Map function and class text objects
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)
	xmap ic <Plug>(coc-classobj-i)
	omap ic <Plug>(coc-classobj-i)
	xmap ac <Plug>(coc-classobj-a)
	omap ac <Plug>(coc-classobj-a)

	" Use CTRL-S for selections ranges.
	" Requires 'textDocument/selectionRange' support of language server.
	nmap <silent> <C-s> <Plug>(coc-range-select)
	xmap <silent> <C-s> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Mappings for CoCList
	" Show all diagnostics.
	nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
	nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

endif
"}}}

"" {{{ WhichKey Plugin
let g:which_key_floating_opts = { 'col': '-2' }
let g:which_key_use_floating_win = 0
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space
let g:which_key_map =  {
	\ '<CR>': 'Clear Highlights'
	\ }
let g:which_key_map.b = { 
			\ 'name' : '+buffers' ,
			\ 'n': 'Next Buffer',
			\ 'p': 'Previous Buffer',
			\ 'd': 'Delete Buffer',
			\ }
let g:which_key_map.f = { 'name' : '+find' }
let g:which_key_map.g = { 'name' : '+git' }
let g:which_key_map.r = { 'name' : '+refactor' }
let g:which_key_map.t = { 
	\ 'name' : '+toggle', 
	\ 'u' : 'Toggle UndoTree',
	\ 'p': 'Toggle Project Tree',
	\ }
" }}}

"" {{{ EditorConfig Plugin
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" }}}

"" {{{ Typescript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
" }}}

"" {{{ Key Mappings
" WhichKey
nnoremap <silent> <leader>      :<c-u>WhichKey  '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
nnoremap <silent> <leader>      :WhichKey       '<Space>'<CR>

" UndoTree
nnoremap <leader>tu :UndotreeToggle<CR>

" Search forward/backward sanity
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" Up/down command history remap
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Clear highligts, fix syntax-highlighting
nnoremap <leader><CR> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" CHADTree 
nnoremap <leader>tp :CHADopen<CR>

" Move selected >>>>
xnoremap <  <gv
xnoremap >  >gv

" Git
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gl :Commits<CR>

" Buffers
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bd :bd<CR>

" Find files/search
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fF :GFiles
nnoremap <silent> <Leader>fs :Rg<CR>
nnoremap <silent> <Leader>fH :Helptags<CR>
nnoremap <silent> <Leader>fh :History<CR>

" Terminal normal mode
tnoremap <Esc> <C-\><C-n>
" }}}

" {{{ VSCode
if exists('g:vscode')
	function! s:split(...) abort
	    let direction = a:1
	    let file = a:2
	    call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
	    if file != ''
		call VSCodeExtensionNotify('open-file', expand(file), 'all')
	    endif
	endfunction

	function! s:splitNew(...)
	    let file = a:2
	    call s:split(a:1, file == '' ? '__vscode_new__' : file)
	endfunction

	function! s:closeOtherEditors()
	    call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
	    call VSCodeNotify('workbench.action.closeOtherEditors')
	endfunction

	function! s:manageEditorSize(...)
	    let count = a:1
	    let to = a:2
	    for i in range(1, count ? count : 1)
		call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
	    endfor
	endfunction

	command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
	command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
	command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
	command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
	command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

	nnoremap <silent> <C-w>s :call <SID>split('h')<CR>
	xnoremap <silent> <C-w>s :call <SID>split('h')<CR>

	nnoremap <silent> <C-w>v :call <SID>split('v')<CR>
	xnoremap <silent> <C-w>v :call <SID>split('v')<CR>

	nnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>
	xnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>

	noremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
	xnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
	noremap <silent> gh :call VSCodeNotify('editor.action.showHover')<CR>
	xnoremap <silent> gh :call VSCodeNotify('editor.action.showHover')<CR>

	nnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
	xnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
	nnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
	xnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
	nnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
	xnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
	nnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
	xnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>

	" Better Navigation
	nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
	xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
	nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
	xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
	nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
	xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
	nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
	xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

	" Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
	xnoremap <silent> <C-/> :call Comment()<CR>
	nnoremap <silent> <C-/> :call Comment()<CR>

	nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

	nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
	xnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
endif
" }}}
