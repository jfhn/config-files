let g:neovide_cursor_trail_size = 0

" This feature only works when neovide is build from source.
let g:neovide_scale_factor = 1.0
let g:neovide_scale_increment_factor = 1.2

fun! ChangeScaleFactor(delta)
	if a:delta == 1
		let g:neovide_scale_factor = 1.0
	else
		let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
	end
	echom "Scale factor: " . string(g:neovide_scale_factor)
endfun

nmap <expr><leader>= ChangeScaleFactor(g:neovide_scale_increment_factor)
nmap <expr><leader>- ChangeScaleFactor(1/g:neovide_scale_increment_factor)
nmap <expr><leader>0 ChangeScaleFactor(1)

"nmap <C-kPlus> ChangeScaleFactor(1.2)
"nmap <C-kMinus> ChangeScaleFactor(1/1.2)

" g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
let g:neovide_transparency = 0.9
let g:transparency = 1

fun! ChangeBackgroundOpacity(alpha)
	let g:neovide_transparency = a:alpha
endfun
