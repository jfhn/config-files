hi clear

if exists('syntax on')
  syntax reset
  hi clear
endif

let g:colors_name = 'aoc-theme'

set background=dark

" https://github.com/noahfrederick/vim-hemisu/
fun! s:hi(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui  : "NONE")
endfun

let s:normal  = "#CCCCCC"
let s:bg      = "#0F0F23"
let s:cursor  = "#ffff66"
let s:comment = "#99ff99"
let s:string  = "#009900"
let s:white   = "#FFFFFF"
let s:space   = "#888888"

call s:hi("Normal", {"fg": s:normal, "bg": s:bg})
hi! link Identifier Normal

call s:hi("Cursor", {"fg": s:bg, "bg": s:cursor})
call s:hi("Comment", {"fg": s:comment})
call s:hi("String", {"fg": s:string, "gui": "bold"})

call s:hi("Function", {"gui": "italic"})
hi! link LuaFunc Function

call s:hi("Statement", {"fg": s:white, "gui": "bold"})
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

call s:hi("Operator", {"fg": s:normal, "gui": "bold"})

call s:hi("Type", {"fg": s:normal, "gui": "bold"})
hi! link Typedef   Type
hi! link Structure Type

call s:hi("Whitespace", {"fg": s:space})
