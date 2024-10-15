if exists("b:current_syntax")
	finish
endif

setlocal ft=noo

" Types
syn match NooType '[A-Z][a-zA-Z0-9_]\+'

" Values
syn match  NooNumber '\d\+'
syn region NooChar start="'" end="'"
syn region NooString start='"' end='"'

syn match NooFunction "\(\w\+\.\)*\zs\w\+\ze\( \+(\?\w\+)\?\)\+"

" syn match NooPatternVar "\(\w\+\.\)*\w\+\|(\(\w\+\.\)*\zs\w\+\ze\( \+(\?\w\+)\?\)\+)" contained

" Keywords
syn keyword NooKeyword define axiom family where public import private module end
syn keyword NooKeywordCase case nextgroup=NooPatternVar skipwhite

" Other
syn region NooLineComment start="\/\/" end="\n"

let b:current_syntax = "noo"

hi def link NooType        Type
hi def link NooNumber      Number
hi def link NooChar        Number
hi def link NooString      String
hi def link NooKeyword     Statement
hi def link NooKeywordCase Statement
hi def link NooFunction    Function
hi def link NooLineComment Comment
