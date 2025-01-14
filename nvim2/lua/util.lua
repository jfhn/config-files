---@param command table
function Make(command)
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

-- Reference:
--   tj_devries, "Everything You Need To Start Writing Lua"
--   https://youtu.be/CuWfgiwI73Q?si=fisbnhOG9UEZ16_3
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end
})
