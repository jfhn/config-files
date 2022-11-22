local M = {};

-- Reference: https://github.com/n3wborn/nvim/blob/main/lua/utils.lua
M.warn = function(msg)
	vim.api.nvim_echo({{msg, 'WarningMsg'}}, true, {})
end

M.notify = function(title, msg, level)
	vim.notify(msg, level, {
		title = title,
	});
end

M.table_keys = function(tab)
	local result = {};
	for k in pairs(tab) do
		result[#result + 1] = k;
	end
	return result;
end

return M;
