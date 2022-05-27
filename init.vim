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

call plug#end()

"Makes the cursor purple, somehow
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

"set guifont=Hasklig:h16
set guifont=Cascadia\ Code:16

" colo darknight
" colo stylus
" colo naysayer88
" colo desert
colo subatomic256
set background=dark
let g:stylus_terminal_italics = 1

let g:aldmeris_termcolors = "tango"

syntax on

set number relativenumber
set noet ci pi sts=0 sw=8 ts=8
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
set nohlsearch
set noswapfile
"set colorcolumn=90
"highlight ColorColumn ctermbg=darkgrey
"

set encoding=utf-8
set fileencoding=utf-8

"key mappings
"
:map <C-TAB> <C-N>

:nmap <C-h> b
:nmap <C-l> w
:nmap <C-k> {
:nmap <C-j> }

set whichwrap+=<,>,h,l,[,]

augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

fun! HighlightNotes()
	syn match myNotes /\%(NOTE:\)/
	hi link myNotes Note
endfu

autocmd bufenter * :call HighlightNotes()
autocmd filetype * :call HighlightNotes()

let c_no_curly_error=1
