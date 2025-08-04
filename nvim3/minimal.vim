" minimal configuration
syntax on
set nu rnu
set ts=4 sts=4 sw=4 noet ai si          " indents with 4-space tab characters
set backspace=indent,eol,start          " make backspace more useful
set listchars=tab:»\ ,trail:·
set list                                " enables list chars
set ruler                               " shows the stuff at the bottom
set belloff=all                         " turns of all bells
set incsearch hls                       " incremental highlighted search
set showcmd                             " shows entered commands on bottom right
set wildmenu                            " adds 'tabable' menu for commands and files
set scrolloff=5                         " adds top and bottom padding
set undodir=~/.vim/undodir
set undofile
set ff=unix ffs=unix                    " always use '\n' and never '\r\n'
set encoding=utf-8 fileencoding=utf-8
set foldmethod=marker                   " use markers `{{{ ... }}}` for folding
if executable("rg")                     " uses ripgrep to find files with :grep <regex> <dir=.>
	set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
	set grepformat=%f:%l:%c:%m
endif
command! MakeTags !ctags -R .           " creates file tags in the current directory
                                        " useful for goto definition etc.

" file browsing
set path+=**                            " allows for fuzzy finding using :find

let g:netrw_banner=0                    " disables banner
let g:netrw_altv=1                      " open splits to the right
let g:netrw_liststyle=3                 " tree view

" minimal extended keymap
nnoremap <C-h> :bprev<Cr>
nnoremap <C-l> :bnext<Cr>
