set_tab_width = function(width)
	width = width and tonumber(width) or 4
	vim.opt.tabstop = width
	vim.opt.shiftwidth = width
end

set_tab_width(4)

vim.cmd("command! -nargs=? SetTabWidth :lua set_tab_width(<args>)")

---@param command table
Make = function(command)
	if #command.fargs > 0 then
		local cmd = ""
		for _, c in ipairs(command.fargs) do
			cmd = cmd .. "\\ " .. c
		end
		vim.cmd("set makeprg=" .. cmd)
	end
	vim.cmd("make")
end

vim.api.nvim_create_user_command("Make", Make, {
	nargs = "*",
	desc = "Updates make program if specified and executes it",
})

vim.opt.listchars = {
	tab = "» ",
	-- space = "·",
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

-- local function colo_fix()
-- 	print("Colo fix")
-- 	vim.cmd("highlight Keyword cterm=bold gui=bold")
-- end

-- vim.api.nvim_create_user_command("ColoFix", colo_fix, {nargs = 0})
