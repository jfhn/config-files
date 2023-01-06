" Refresh the vim environment with :so %

source <sfile>:h/plugins.vim
source <sfile>:h/settings.vim

lua require("ui");
lua require("editor");
lua require("_cmp");
lua require("lsp");
lua require("telescope-config")

source <sfile>:h/mappings.vim
source <sfile>:h/hooks.vim

if exists("g:neovide")
	source <sfile>:h/neovide.vim
endif

lua BGTransparency(0);

fun! HighlightNotes()
	syn match myNotes /\%(NOTE:\)/
	hi link myNotes Note
endfu

autocmd bufenter * :call HighlightNotes()
autocmd filetype * :call HighlightNotes()
