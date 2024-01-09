hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='jb-like'

set background=dark

let s:bg             = { "gui": "#072626", "cterm": "1" }
let s:norm           = { "gui": "#D3B58D", "cterm": "15"  }
let s:ident          = { "gui": "#C8D4EC", "cterm": "15"  }
let s:comment        = { "gui": "#3FDF1F", "cterm": "15"  }
let s:white          = { "gui": "#FFFFFF", "cterm": "231" }
let s:string         = { "gui": "#0FDFAF", "cterm": "231" }

function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

call s:h("Normal",            {"fg": s:norm, "bg": s:bg})

call s:h("Identifier",        {"fg": s:ident, "bg": s:bg})
hi! link @variable            Identifier

call s:h("Comment",           {"fg": s:comment})

call s:h("Function",          {"fg": s:ident})
hi! link LuaFunc              Function

call s:h("Statement",         {"fg": s:white})
hi! link Conditonal           Statement
hi! link Repeat               Statement
hi! link Label                Statement
hi! link Keyword              Statement
hi! link cType                Statement
hi! link cTypedef             Statement
hi! link cStructure           Statement
hi! link Exception            Statement
hi! link StorageClass         Statement
hi! link LuaFunction          Statement
hi! link rustKeyword          Statement
hi! link hsTypedef            Statement
hi! link hsStructure          Statement
hi! link hsNewtypedef         hsTypedef
hi! link scalaKeywordModifier Statement
hi! link scalaSpecial         Statement

call s:h("String",            {"fg": s:string})
hi! link Character            String
