-- Map leader and localleader for Coq to ','.
vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPre", "BufRead"}, {
	pattern = {"*.v"},
	callback = function()
		print("map leader to ','");
		vim.g.mapleader = ",";
		vim.g.maplocalleader = ",";
	end
})
