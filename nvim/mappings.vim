let mapleader = " "

map <C-k> {
map <C-j> }

" Map Ctrl+Backspace to delete last word in insert mode.
noremap! <C-BS> <C-w>
noremap! <C-h>  <C-w>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db

nnoremap <C-x>g <cmd>LazyGit<cr>

" TODO: Do this in a seperate lua file.
nnoremap <leader>ps <cmd>lua require('telescope.builtin').grep_string({search = vim.fn.input("Grep for > ")})<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <C-p> <cmd>lua require('telescope.builtin').git_files()<cr>

"map <leader>= <cmd>lua ui_increase_fontsize()<cr>
"map <leader>- <cmd>lua ui_decrease_fontsize()<cr>
"nmap <M-=> <cmd>lua ui_increase_fontsize()<cr>
"nmap <M--> <cmd>lua ui_decrease_fontsize()<cr>
