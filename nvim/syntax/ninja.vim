if exists("b:current_syntax")
	finish
endif

" Types
syn keyword NinjaBuiltinType Int Char Str
syn match NinjaType '[a-zA-Z0-9_]: \+\[\?\]\?[a-zA-Z0-9_]\+'hs=s+3
" syn match NinjaTypeDef 'type \+[a-zA-Z0-9_]\+'hs=s+5

" Values
syn match  NinjaNumber '\d\+'
syn region NinjaChar start="'" end="'"
syn region NinjaString start='"' end='"'

" Keywords
syn keyword NinjaKeyword break case const continue default do else for if lambda new nil record return sizeof switch type var while

" Other
syn match NinjaFunction '[a-zA-Z0-9_]\+('he=e-1
syn region NinjaLineComment start="\/\/" end="\n"

let b:current_syntax = "ninja"

hi def link NinjaBuiltinType Type
hi def link NinjaType        Type
" hi def link NinjaTypeDef     Type
hi def link NinjaNumber      Number
hi def link NinjaChar        Number
hi def link NinjaString      String
hi def link NinjaFunction    Function
hi def link NinjaKeyword     Statement
hi def link NinjaLineComment Comment
