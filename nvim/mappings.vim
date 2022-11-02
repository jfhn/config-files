let mapleader = " "

:map  <C-TAB>   <C-N>
:map  <C-g>     <ESC>
:map  <C-c>     <ESC>

:nmap <C-h>     b
:nmap <C-l>     w
:nmap <C-k>     {
:nmap <C-j>     }

:vmap <C-h>     b
:vmap <C-l>     w
:vmap <C-k>     {
:vmap <C-j>     }

" TODO: Do this in a seperate lua file.
nnoremap <leader>ps <cmd>lua require('telescope.builtin').grep_string({search = vim.fn.input("Grep for > ")})<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"map <leader>= <cmd>lua ui_increase_fontsize()<cr>
"map <leader>- <cmd>lua ui_decrease_fontsize()<cr>
"nmap <M-=> <cmd>lua ui_increase_fontsize()<cr>
"nmap <M--> <cmd>lua ui_decrease_fontsize()<cr>
