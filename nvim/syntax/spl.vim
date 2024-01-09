if exists("b:current_syntax")
	finish
endif

" Highlight keywords.
syntax keyword splKeyword array else if of proc ref type var while

" syntax case match
"
" setlocal iskeyword+=-
" setlocal iskeyword+=:
" setlocal iskeyword+=<
" setlocal iskeyword+=>
" setlocal iskeyword+=%
" setlocal iskeyword+=@
" setlocal iskeyword+=!
" setlocal iskeyword+=?
" setlocal iskeyword+=^
" "setlocal iskeyword+=~
" "setlocal iskeyword+=#
" "setlocal iskeyword+=*
" "setlocal iskeyword+=/
" "setlocal iskeyword+=\\
" "setlocal iskeyword+=.
" "setlocal iskeyword+=&
" setlocal iskeyword+=|
" setlocal iskeyword+=:
" setlocal iskeyword+=
" "setlocal iskeyword+=,
" "setlocal iskeyword+=;
" "setlocal iskeyword+=_
" "setlocal iskeyword+=
" "setlocal iskeyword+=+
" "setlocal iskeyword+=(
" "setlocal iskeyword+=)
" "setlocal iskeyword+={
" "setlocal iskeyword+=}
" "setlocal iskeyword+=[
" "setlocal iskeyword+=]
" "setlocal iskeyword+=$
"
" " Highlight comments
" syntax match splComment "//.*$" contained
"
" " Highlight chars
" syntax match splString "'.'|'\\n'" contained
"
" " Set file type for .spl files.
" au BufNewFile,BufRead *.spl set filetype=spl
