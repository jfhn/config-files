let mapleader = " "
let maplocalleader = " "

nnoremap <Leader>ft <cmd>NvimTreeToggle<cr>
nnoremap <Leader>fp <cmd>Telescope git_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <C-h> <cmd>:bprev<cr>
nnoremap <C-l> <cmd>:bnext<cr>
