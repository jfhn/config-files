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

local transparent_groups = {
	"Normal",
	"NonText",
	"SignColumn"
}

BGTransparency = function(set_transparent)
	if set_transparent == false then
		local current_theme = vim.api.nvim_exec("colorscheme", true)
		vim.cmd("colorscheme " .. current_theme)
		return
	end

	for _, group in ipairs(transparent_groups) do
		vim.cmd(string.format("hi %s ctermbg=NONE guibg=NONE", group))
	end
end
