set number
set mouse=a
set encoding=utf-8
set noswapfile

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set autoindent
set scrolloff=7
set colorcolumn=79
set updatetime=300
set nocompatible

" Give more space for displaying messages.
set cmdheight=2

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

highlight ColorColumn ctermbg=60
highlight LineNr ctermfg=140


" jk ESC
inoremap jk <esc>


let g:ale_disable_lsp = 1


" Plugins
call plug#begin('~/nvim/site/autoload/plug.vim')

Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vimrc'
Plug 'sheerun/vim-polyglot'                             " Better syntax-highlighting for filetypes
Plug 'jiangmiao/auto-pairs'
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }    " AI-autocompete
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Code autocomplete and snippets (:CocInstall coc-pyright /
                                                        " clangd / html / json / tsserver / sql-language-server)
Plug 'dense-analysis/ale'                               " Code formatting
Plug 'dracula/vim'                                      " Colorscheme

call plug#end()


" Turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Colorscheme
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE
hi MatchParen cterm=none ctermbg=blue ctermfg=green

" Highlighting
let g:python_highlight_all = 1


" Terminal
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-/> :call OpenTerminal()<CR>


" COC
" prittier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" ALE
" Linting and Fixing
let g:ale_linters = {
\   'c': ['clang'],
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'c': ['clang-format'],
\   'javascript': ['prettier-eslint'],
\   'python': ['black']
\}

let g:ale_fix_on_save = 1
