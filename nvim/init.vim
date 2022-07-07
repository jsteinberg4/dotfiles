" Plugins
call plug#begin('~/.config/nvim/plugs')
Plug 'drewtempelmeyer/palenight.vim'  " theme
Plug 'vim-airline/vim-airline' " Status bar
Plug 'sheerun/vim-polyglot' " Multi-lang support
Plug 'preservim/tagbar' " tags
Plug 'universal-ctags/ctags' " tags for C
Plug 'luochen1990/rainbow' " Rainbow brackets
Plug 'vim-syntastic/syntastic' " Syntax checking
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround' " Brackets
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " Smarter language servers, etc
Plug 'tommcdo/vim-lion' " Better aligning
Plug 'ntpeters/vim-better-whitespace'

Plug 'morhetz/gruvbox' " Other theme
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" Requirements for netrw
set nocp
filetype plugin on

" Get syntax files from config folder
set runtimepath+=~/.config/nvim/plugs/vim-polyglot/syntax/

" Set default theme
" colorscheme palenight
colorscheme gruvbox

" Disable C-z from job-controlling neovim
nnoremap <c-z> <nop>

" Remap C-c to <esc>
nmap <c-c> <esc>
imap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>

" Syntax highlighting
syntax on

" Position in code
set number
set ruler

" Don't make noise
set visualbell

" Default file encoding
set encoding=utf-8

" Line wrap on/off
" set nowrap
set wrap

" When to have a status line. 2=always
set laststatus=2

" Highlight search results
set hlsearch
set incsearch

" auto & smart indent
set autoindent
set smartindent

" Something for screen/tmux. Unclear what this does
set t_Co=256

" Mouse support
set mouse=a

" Map F8 to TagBar (something w/ tagbar plugin?)
nmap <F8> :TagbarToggle<CR>

" Disable backup files -- Some Language servers have issues w/ backup files
" (COC)
set nobackup
set nowritebackup

" no delays!
set updatetime=300

" Cmdline changes
set cmdheight=2
set shortmess+=c

set signcolumn=yes

" Coc.nvim: TextEdit may fail if hidden is not set
set hidden

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Set <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" ============================
"     Markdown Config
" =============================
" Open preview window on entering markdown buffer
" Values: 0 (off), 1 (on)
" Default: 0 (off)
let g:mkdp_auto_start=0

" Auto close markdown preview when changing buffers
" Values: 0 (off), 1 (on)
" Default: 1
let g:mkdp_auto_close = 1

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" Use '[g' and ']g' to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Applying codeAction to the selected region
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on current line
nmap <leader>qf <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selection ranges
" Requires 'textDocument/selectionRange' support from language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add ':Format' command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add ':Fold' command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add ':OR' command for organize imports of the current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CocList
" Show all diagnostics
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p :<C-u>CocListResume<CR>
" Open file explorer
nnoremap <silent><nowait> <space>E :<C-u>CocCommand explorer<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Function: set tab width to n spaces
function! SetTab(n)
	let &l:tabstop=a:n
	let &l:softtabstop=a:n
	let &l:shiftwidth=a:n
	set expandtab
endfunction
command! -nargs=1 SetTab call SetTab(<f-args>)

" Function: Trim extra whitespace on the whole file
function! Trim()
	let l:save = winsaveview()
	keeppatterns %s/\s\+\$//e
	call winrestview(l:save)
endfun
command! -nargs=0 Trim call Trim()

" Set tab for completion
" WARN: Use ':verbose imap <tab>' first to check for conflicting mappings
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif


augroup mygroup
	autocmd!
	" Setup formatexpr specified filetypes(s)
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	"Update signature help on jumpy placeholder
	autocmd user CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add (Neo)Vim's native statusline support.
" NOTE: Please see ':h coc-status' for integrations w/ external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Add cocstatus into lightline
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\ 	'left': [ [ 'mode', 'paste' ],
			\ 					  [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\ 	'cocstatus': 'coc#status'
			\ },
			\ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
