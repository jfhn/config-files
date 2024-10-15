augroup IndentationSettings
  autocmd!

  " default indentation
  autocmd FileType * set noet ts=4 sw=4 sts=4

  " two spaces languages
  autocmd FileType ocaml,haskell,markdown,scala,vim,tex,noo,ninja set et ts=2 sw=2 sts=2

  " four spaces languages
  autocmd FileType java set et ts=4 sw=4 sts=2
augroup END

autocmd ColorScheme * hi NonText guifg=#777777 guibg=none
