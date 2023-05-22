syntax on
language en_US

"Makes the cursor purple, somehow
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10
set guicursor=

set exrc
set hidden
set number relativenumber
set noet ci pi sts=0 sw=4 ts=4
set ai
set noerrorbells
set smartindent
set wrap tw
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set ff=unix
set clipboard=unnamed

set encoding=utf-8
set fileencoding=utf-8

set whichwrap+=<,>,h,l,[,]

set termguicolors
colo gruber-darker
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight SignColumn ctermbg=none
highlight Keyword cterm=bold
"colo ayu-mirage
"highlight LineNr guifg=#FFE6B3
"highlight LineNr guifg=#FFCC66
set background=dark

set completeopt=menu,menuone,noselect

let c_no_curly_error=1
let g:stylus_terminal_italics=1
" let g:nvim_tree_show_icons = {git = 0, folders = 0, files = 0, folder_arrows = 0

autocmd! BufNewFile,BufReadPre,FileReadPre *.* set noexpandtab
autocmd! BufNewFile,BufReadPre,FileReadPre *.hs set expandtab
