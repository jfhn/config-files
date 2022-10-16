" This does not work in any release version yet, the feature was added on 07.10.2022.
let g:neovide_scale_factor = 1.0

fun! ChangeScaleFactor(delta)
	let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
endfun

"nnoremap <expr><leader>= ChangeScaleFactor(1.2)
"nnoremap <expr><leader>_ ChangeScaleFactor(1/1.2)

" g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
let g:neovide_transparency = 0.9
let g:transparency = 1

fun! ChangeBackgroundOpacity(alpha)
	let g:neovide_transparency = a:alpha
endfun
