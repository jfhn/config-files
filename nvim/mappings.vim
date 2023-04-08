let mapleader = " "

map <C-k> {
map <C-j> }

" Map Ctrl+Backspace to delete last word in insert mode.
noremap! <C-BS> <C-w>
noremap! <C-h>  <C-w>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db
