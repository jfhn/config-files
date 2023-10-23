if exists("b:current_syntax")
	finish
endif

" Types
syn match NooType '[A-Z][a-zA-Z0-9_]\+'

" Values
syn match  NooNumber '\d\+'
syn region NooChar start="'" end="'"
syn region NooString start='"' end='"'

" Keywords
syn keyword NooKeyword define axiom family where case

" Other
syn region NooLineComment start="\/\/" end="\n"

let b:current_syntax = "noo"

hi def link NooType        Type
hi def link NooNumber      Number
hi def link NooChar        Number
hi def link NooString      String
hi def link NooKeyword     Statement
hi def link NooLineComment Comment
