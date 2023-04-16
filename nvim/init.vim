" Refresh the vim environment with :so %

source <sfile>:h/plugins.vim
source <sfile>:h/settings.vim

lua require("init");

source <sfile>:h/mappings.vim
source <sfile>:h/hooks.vim

if exists("g:neovide")
	source <sfile>:h/neovide.vim
endif

TBT " Toggle background transparency

fun! HighlightNotes()
	syn match myNotes /\%(NOTE:\)/
	hi link myNotes Note
endfu

autocmd bufenter * :call HighlightNotes()
autocmd filetype * :call HighlightNotes()
