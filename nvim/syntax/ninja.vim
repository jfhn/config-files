if exists("b:current_syntax")
	finish
endif

setlocal ft=ninja

" Types
" syn keyword NinjaBuiltinType Int Char Str
" syn region NinjaTypeDef start="type" end="\(\h\w*\)\@=" contains=NinjaTypeExp
" syn region NinjaTypeExp start=":" end="$\|,\|\\)\|)" contains=NinjaTypeExp
" syn match NinjaTypeDef "type \+\zs\w\+\ze *= *\zs\w\+\ze;"
" syn match NinjaTypeExp "\(\w\+\ze::\w\+\)\|\(\w\+\)"
" syn match NinjaTypeExp /\%(\[.*\]\)\|\(\w\+::\zs\w\+\ze\)\|\(\w\+\)/
" syn match NinjaType '[a-zA-Z0-9_]: \*\[\?\]\?\*[a-zA-Z0-9_]\+'hs=s+3
" syn match NinjaTypeDef 'type \+[a-zA-Z0-9_]\+'hs=s+5

" Values
syn match  NinjaNumber '-*\d\+\|true\|false'
syn region NinjaChar start="'" end="'"
syn region NinjaString start='"' end='"'

syn match NinjaIdent "[a-zA-Z_][a-zA-Z0-9_]\+"

" Keywords
syn keyword NinjaKeyword break case const continue default do else for if lambda nil record return sizeof switch var while module import public initialize
syn keyword NinjaKeywordType type nextgroup=NinjaTypeDef skipwhite
syn keyword NinjaKeywordIs is nextgroup=NinjaTypeExp skipwhite
syn keyword NinjaKeywordNew new nextgroup=NinjaNewExp skipwhite

" Other
syn match NinjaFunction /[a-zA-Z_][a-zA-Z0-9_]\+\s*(/he=e-1
" syn match NinjaVariable "\w\+\s*:" nextgroup=NinjaTypeExp skipwhite
syn match NinjaTypeIntro ":" nextgroup=NinjaTypeExp skipwhite
syn match NinjaCast ".+(:" nextgroup=NinjaTypeExp skipwhite
syn region NinjaNewExp start="(" end=")" contained contains=NinjaTypeExp
syn region NinjaLineComment start="\/\/" end="\n"

syn match NinjaTypeDef "\w\+\ze *=" contained nextgroup=NinjaTypeExp skipwhite
syn match NinjaTypeExp "\(\[\s*\]\s*\)*\(\w\+\s*::\s*\w\+\|\w\+\)" contained contains=NinjaTypeExprArray,NinjaTypeExpQual
syn match NinjaTypeExprArray /\[\s*\]/ contained
" syn match NinjaTypeExpName /\w\+/ contained
syn match NinjaTypeExpQual /\w\+::\zs\w\+\ze\|\w\+/ contained
" syn match NinjaTypeExpArray "\(\[\s*\]\)\|" contained nextgroup=NinjaTypeExpName skipwhite
" syn match NinjaTypeExpArray "\(\[\s*\]\s*\)*\w\+" contained
syn match NinjaQualifier "\w\+\s*::"

let b:current_syntax = "ninja"

" hi def link NinjaBuiltinType Type
hi def link NinjaTypeDef     Type
" hi def link NinjaTypeExp     Type
hi def link NinjaCast        String
hi def link NinjaTypeExpName Type
hi def link NinjaTypeExpQual Type
hi def link NinjaTypeExpArray Type
hi def link NinjaVariable    Normal
hi def link NinjaQualifier   Normal
" hi def link NinjaTypeDef     Type
hi def link NinjaNumber      Number
hi def link NinjaIdent       Normal
hi def link NinjaChar        Number
hi def link NinjaString      String
hi def link NinjaFunction    Function
hi def link NinjaKeyword     Keyword
hi def link NinjaKeywordType Keyword
hi def link NinjaKeywordIs   Keyword
hi def link NinjaKeywordNew  Keyword
hi def link NinjaLineComment Comment
