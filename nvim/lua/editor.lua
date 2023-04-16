set_tab_width = function(width)
	width = width and tonumber(width) or 4
	vim.opt.tabstop = width
	vim.opt.shiftwidth = width
end

set_tab_width(4)

vim.cmd("command! -nargs=? SetTabWidth :lua set_tab_width(<args>)")

vim.opt.listchars = {
	tab = "| ",
	space = "·",
	trail = "·"
}
vim.opt.list = true

-- local transparent_groups = {"Normal", "SignColumn", "FoldColumn", "LineNr", "CursorLineNr"}
local transparent_groups = {
	"Normal",
	"NonText",
	"SignColumn"
}

local is_transparent = false;
vim.cmd("command! TBT :lua toggle_transparency()")

toggle_transparency = function()
	is_transparent = not is_transparent;

	if is_transparent then
		for _, group in ipairs(transparent_groups) do
			vim.cmd(string.format("hi %s ctermbg=NONE guibg=NONE", group))
		end
	else
		local current_theme = vim.api.nvim_exec("colorscheme", true)
		vim.cmd("colorscheme " .. current_theme)
	end
end
