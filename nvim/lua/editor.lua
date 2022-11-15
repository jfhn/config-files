SetTabWidth = function(width)
	vim.opt.tabstop = width
	vim.opt.shiftwidth = width
end

SetTabWidth(4)

vim.opt.listchars = {
	tab = "| ",
	space = "·",
	trail = "·"
}
vim.opt.list = true
