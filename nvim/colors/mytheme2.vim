" Original:   https://github.com/owickstrom/vim-colors-paramount
" Name:       paramount.vim
" Version:    0.1.0
" Maintainer: github.com/owickstrom
" License:    The MIT License (MIT)
"
" A minimal colorscheme for Vim that only puts emphasis on the paramount.
"
" Based on the pencil and off colorschemes:
"
" https://github.com/reedes/vim-colors-pencil
" https://github.com/reedes/vim-colors-off
"
"
" This is my personal modification.

"""

hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='mylight2'

let s:black           = { "gui": "#000000", "cterm": "232" }
let s:medium_gray     = { "gui": "#767676", "cterm": "243" }
let s:white           = { "gui": "#F1F1F1", "cterm": "15"  }
let s:actual_white    = { "gui": "#FFFFFF", "cterm": "231" }
let s:subtle_black    = { "gui": "#303030", "cterm": "236" }
let s:light_black     = { "gui": "#262626", "cterm": "235" }
let s:lighter_black   = { "gui": "#4E4E4E", "cterm": "239" }
let s:light_gray      = { "gui": "#A8A8A8", "cterm": "248" }
let s:lighter_gray    = { "gui": "#C6C6C6", "cterm": "251" }
let s:lightest_gray   = { "gui": "#EEEEEE", "cterm": "255" }
let s:pink            = { "gui": "#fb007a", "cterm": "9"   }
let s:dark_red        = { "gui": "#a00000", "cterm": "1"   }
let s:light_red       = { "gui": "#E32791", "cterm": "1"   }
let s:orange          = { "gui": "#D75F5F", "cterm": "167" }
let s:darker_blue     = { "gui": "#005F87", "cterm": "18"  }
let s:dark_blue       = { "gui": "#008EC4", "cterm": "32"  }
let s:blue            = { "gui": "#20BBFC", "cterm": "12"  }
let s:light_blue      = { "gui": "#b6d6fd", "cterm": "153" }
let s:dark_cyan       = { "gui": "#20A5BA", "cterm": "6"   }
let s:light_cyan      = { "gui": "#4FB8CC", "cterm": "14"  }
let s:dark_green      = { "gui": "#00a000", "cterm": "2"   }
let s:darker_green    = { "gui": "#008000", "cterm": "2"   }
let s:light_green     = { "gui": "#5FD7A7", "cterm": "10"  }
let s:chartreuse1     = { "gui": "#87FF00", "cterm": "83"  }
let s:dark_purple     = { "gui": "#7f3fa7", "cterm": "134" }
let s:purple          = { "gui": "#000000", "cterm": "10" }
let s:light_purple    = { "gui": "#AF87FF", "cterm": "141" }
let s:yellow          = { "gui": "#FFFF00", "cterm": "11"  }
let s:light_yellow    = { "gui": "#ffff87", "cterm": "228" }
let s:dark_yellow     = { "gui": "#A89C14", "cterm": "3"   }

let s:background = &background

if &background == "dark"
  let s:bg              = s:black
  let s:bg_subtle       = s:lighter_black
  let s:bg_very_subtle  = s:subtle_black
  let s:norm            = s:white
  let s:norm_subtle     = s:medium_gray
  let s:purple          = s:light_purple
  let s:cyan            = s:light_cyan
  let s:green           = s:chartreuse1
  let s:red             = s:light_red
  let s:keyword         = s:yellow
  let s:visual          = s:light_purple
  let s:yellow          = s:light_yellow
  let s:strong          = s:white
  let s:status_current  = s:black
  let s:status_other    = s:lighter_black
else
  let s:bg              = s:actual_white
  let s:bg_subtle       = s:light_gray
  let s:bg_very_subtle  = s:lightest_gray
  let s:norm            = s:light_black
  let s:norm_subtle     = s:medium_gray
  let s:purple          = s:dark_purple
  let s:cyan            = s:dark_cyan
  let s:green           = s:darker_green
  let s:red             = s:dark_red
  let s:keyword         = s:purple
  let s:visual          = s:light_purple
  let s:yellow          = s:dark_yellow
  let s:strong          = s:black
  let s:status_current  = s:actual_white
  let s:status_other    = s:white
endif

" https://github.com/noahfrederick/vim-hemisu/
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

call s:h("Normal",        {"fg": s:norm})
hi! link Identifier       Normal

" restore &background's value in case changing Normal changed &background (:help :hi-normal-cterm)
if &background != s:background
   execute "set background=" . s:background
endif

call s:h("Cursor",        {"bg": s:purple, "fg": s:norm, "gui": "reverse", "cterm": "reverse"})
call s:h("Comment",       {"fg": s:light_gray, "gui": "bold", "cterm": "bold"})

call s:h("Constant",      {"fg": s:darker_blue})
hi! link Character        Constant
hi! link Number           Constant
hi! link Boolean          Constant
hi! link Float            Constant

call s:h("String",        {"fg": s:green, "cterm": "bold", "gui": "bold"})
hi! link hsPragma         String

call s:h("Function",      {"cterm": "italic", "gui": "italic"})
hi! link LuaFunc          Function

call s:h("Statement",         {"fg": s:dark_purple, "cterm": "bold", "gui": "bold"})
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

call s:h("Operator",      {"fg": s:norm, "cterm": "bold", "gui": "bold"})

call s:h("PreProc",       {"fg": s:strong})
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

call s:h("Type",          {"fg": s:norm, "cterm": "bold", "gui": "bold"})
hi! link Typedef          Type
hi! link Structure        Type

call s:h("Special",       {"fg": s:norm})
hi! link SpecialChar      Special
hi! link Tag              Special
hi! link Delimiter        Special
hi! link SpecialComment   Special
hi! link Debug            Special

call s:h("Whitespace",    {"fg": s:light_gray})

call s:h("Underlined",    {"fg": s:norm, "gui": "underline", "cterm": "underline"})
call s:h("Ignore",        {"fg": s:bg})
call s:h("Error",         {"fg": s:actual_white, "bg": s:red, "cterm": "bold"})
call s:h("Todo",          {"fg": s:purple, "cterm": "bold", "gui": "bold"})
call s:h("SpecialKey",    {"fg": s:green})
call s:h("NonText",       {"fg": s:medium_gray})
call s:h("Directory",     {"fg": s:blue})
call s:h("ErrorMsg",      {"fg": s:red})
call s:h("IncSearch",     {"bg": s:blue, "fg": s:black})
call s:h("Search",        {"bg": s:blue, "fg": s:black})
call s:h("MoreMsg",       {"fg": s:medium_gray, "cterm": "bold", "gui": "bold"})
hi! link ModeMsg MoreMsg
call s:h("LineNr",        {"fg": s:bg_subtle})
call s:h("CursorLineNr",  {"fg": s:dark_red, "bg": s:bg_very_subtle})
call s:h("Question",      {"fg": s:red})
call s:h("StatusLine",    {"bg": s:norm, "fg": s:status_current})
call s:h("StatusLineNC",  {"bg": s:norm, "fg": s:status_other})
call s:h("VertSplit",     {"fg": s:black})
call s:h("Title",         {"fg": s:blue})
call s:h("Visual",        {"fg": s:norm, "bg": s:visual})
call s:h("VisualNOS",     {"bg": s:bg_subtle})
call s:h("WarningMsg",    {"fg": s:yellow})
call s:h("WildMenu",      {"fg": s:bg, "bg": s:norm})
call s:h("Folded",        {"fg": s:medium_gray})
call s:h("FoldColumn",    {"fg": s:bg_subtle})
call s:h("DiffAdd",       {"fg": s:green})
call s:h("DiffDelete",    {"fg": s:red})
call s:h("DiffChange",    {"fg": s:dark_yellow})
call s:h("DiffText",      {"fg": s:dark_blue})
call s:h("SignColumn",    {"fg": s:light_green})


if has("gui_running")
  call s:h("SpellBad",    {"gui": "underline", "sp": s:red})
  call s:h("SpellCap",    {"gui": "underline", "sp": s:light_green})
  call s:h("SpellRare",   {"gui": "underline", "sp": s:pink})
  call s:h("SpellLocal",  {"gui": "underline", "sp": s:dark_green})
else
  call s:h("SpellBad",    {"cterm": "underline", "fg": s:red})
  call s:h("SpellCap",    {"cterm": "underline", "fg": s:light_green})
  call s:h("SpellRare",   {"cterm": "underline", "fg": s:pink})
  call s:h("SpellLocal",  {"cterm": "underline", "fg": s:dark_green})
endif

call s:h("Pmenu",         {"fg": s:norm, "bg": s:bg_subtle})
call s:h("PmenuSel",      {"fg": s:norm, "bg": s:purple})
call s:h("PmenuSbar",     {"fg": s:norm, "bg": s:bg_subtle})
call s:h("PmenuThumb",    {"fg": s:norm, "bg": s:bg_subtle})
call s:h("TabLine",       {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("TabLineSel",    {"fg": s:purple, "bg": s:bg_subtle, "gui": "bold", "cterm": "bold"})
call s:h("TabLineFill",   {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("CursorColumn",  {"bg": s:bg_very_subtle})
call s:h("CursorLine",    {"bg": s:bg_very_subtle})
call s:h("ColorColumn",   {"bg": s:bg_subtle})

call s:h("MatchParen",    {"bg": s:bg_subtle, "fg": s:norm})
call s:h("qfLineNr",      {"fg": s:medium_gray})

hi! link htmlH1 Statement
hi! link htmlH2 String
hi! link htmlH3 Statement
hi! link htmlH4 String
hi! link htmlH5 Statement
hi! link htmlH6 String

" Synatastic
call s:h("SyntasticWarningSign",    {"fg": s:yellow})
call s:h("SyntasticWarning",        {"bg": s:yellow, "fg": s:black, "gui": "bold", "cterm": "bold"})
call s:h("SyntasticErrorSign",      {"fg": s:red})
call s:h("SyntasticError",          {"bg": s:red, "fg": s:white, "gui": "bold", "cterm": "bold"})

" Neomake
hi link NeomakeWarningSign          SyntasticWarningSign
hi link NeomakeErrorSign            SyntasticErrorSign

" ALE
hi link ALEWarningSign              SyntasticWarningSign
hi link ALEErrorSign                SyntasticErrorSign

" Signify, git-gutter
hi link SignifySignAdd              LineNr
hi link SignifySignDelete           LineNr
hi link SignifySignChange           LineNr
hi link GitGutterAdd                LineNr
hi link GitGutterDelete             LineNr
hi link GitGutterChange             LineNr
hi link GitGutterChangeDelete       LineNr
