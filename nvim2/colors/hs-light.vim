hi clear

if exists('syntax on')
  syntax reset
  hi clear
endif

let g:colors_name = 'hs-light'

set background=light

" https://github.com/noahfrederick/vim-hemisu/
fun! s:hi(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui  : "NONE")
endfun

let s:normal   = "#073642"
let s:bg       = "#FDF6E3"
let s:keyword  = "#AF005F"
let s:type     = "#5F5FAF"
let s:cursor   = "#9F9FEF"
let s:comment  = "#8A8A8A"
let s:string   = "#2AA198"
let s:operator = "#D33682"
let s:number   = "#268BD2"

call s:hi("Normal", {"fg": s:normal, "bg": s:bg})
hi! link Identifier Normal

call s:hi("Cursor", {"fg": s:bg, "bg": s:cursor})
call s:hi("Comment", {"fg": s:comment})
call s:hi("String", {"fg": s:string})
hi! link hsPragma         String
hi! link PreProc          String
hi! link Include          String
hi! link Define           String
hi! link Macro            String
hi! link PreCondit        String

call s:hi("Number", {"fg": s:number})
hi! link Character Number
hi! link Constant  Number
hi! link Boolean   Number
hi! link Float     Number

call s:hi("Function", {"gui": "italic"})
hi! link LuaFunc Function

call s:hi("Statement", {"fg": s:keyword})
hi! link Conditonal           Statement
hi! link Repeat               Statement
hi! link Label                Statement
hi! link Keyword              Statement
hi! link Exception            Statement
hi! link StorageClass         Statement
hi! link LuaFunction          Statement
hi! link rustKeyword          Statement
hi! link hsTypedef            Statement
hi! link hsStructure          Statement
hi! link hsNewtypedef         hsTypedef
hi! link scalaKeywordModifier Statement
hi! link scalaSpecial         Statement

call s:hi("Operator", {"fg": s:normal})

call s:hi("Type", {"fg": s:normal})
hi! link Typedef   Type
hi! link Structure Type

call s:hi("Whitespace", {"fg": s:comment})
call s:hi("Underlined",    {"fg": s:normal, "gui": "underline"})
call s:hi("Todo",          {"fg": s:type, "gui": "bold"})
