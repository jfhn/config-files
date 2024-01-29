augroup AnyFileAutoGroup
  autocmd BufNewFile,BufReadPre,FileReadPre * set noet
  autocmd BufNewFile,BufReadPre,FileReadPre * set ff=unix
augroup END

augroup WhiteSpaceLanguagesGroup
  autocmd BufNewFile,BufReadPre,FileReadPre *.hs,*.java,*.scala,*.ml *.nj *.noo set et
augroup END

autocmd! AnyFileAutoGroup
autocmd! WhiteSpaceLanguagesGroup

autocmd ColorScheme * hi NonText guifg=#777777 guibg=none
