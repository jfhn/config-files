" Refresh the vim environment with :so %

"plugins

call plug#begin('~/AppData/Local/nvim/plugged')

Plug 'morhetz/gruvbox'
"Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'
"Plug 'lyuts/vim-rtags'
"Plug 'git@github.com:kien/ctrlp.vim.git'
"Plug 'git@github.com:Valloric/YouCompleteMe.git'
Plug 'mbbill/undotree'
"Plug 'tomasiser/vim-code-dark'
Plug 'AlessandroYorba/Despacio'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jansedivy/jai.vim'
Plug '~/dev/VimDarkColo'
Plug 'git@github.com:nickburlett/vim-colors-stylus.git'
Plug 'udalov/kotlin-vim'
Plug 'jhlgns/naysayer88.vim'
Plug 'git@github.com:veloce/vim-aldmeris'
Plug 'git@github.com:d11wtq/subatomic256.vim.git'
Plug 'git@github.com:JuliaEditorSupport/julia-vim'
Plug 'alligator/accent.vim'
Plug 'dim13/smyck.vim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

"Makes the cursor purple, somehow
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10
set guicursor=

"set guifont=Hasklig:h16
"set guifont=Cascadia\ Code:16
set guifont=Ubuntu\ Mono\ Ligaturized:16

" colo darknight
" colo stylus
" colo naysayer88
" colo desert
" colo subatomic256
colo accent
set background=dark
let g:stylus_terminal_italics = 1

let g:aldmeris_termcolors = "tango"

syntax on

set exrc
set hidden
set number relativenumber
set noet ci pi sts=0 sw=4 ts=4
set ai
set noerrorbells
set smartindent
"set nowrap
set wrap
set linebreak
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set nohlsearch
set signcolumn=yes
"set colorcolumn=90
"highlight ColorColumn ctermbg=darkgrey
"

set encoding=utf-8
set fileencoding=utf-8

"key mappings

let mapleader = " "

:map  <C-TAB>   <C-N>
:map  <C-G>     <ESC>

:nmap <C-h>     b
:nmap <C-l>     w
:nmap <C-k>     {
:nmap <C-j>     }
:nmap <C-Space> v

:vmap <C-h>     b
:vmap <C-l>     w
:vmap <C-k>     {
:vmap <C-j>     }

nnoremap <leader>ps <cmd>lua require('telescope.builtin').grep_string({search = vim.fn.input("Grep for > ")})<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

set whichwrap+=<,>,h,l,[,]

fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

fun! HighlightNotes()
	syn match myNotes /\%(NOTE:\)/
	hi link myNotes Note
endfu

augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
	autocmd BufWritePre * :call TrimWhitespace()
augroup END

autocmd bufenter * :call HighlightNotes()
autocmd filetype * :call HighlightNotes()

let c_no_curly_error=1
