-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{"Failed to clone lazy.nvim:\n", "ErrorMsg"},
			{out, "WarningMsg"},
			{"\nPress any key to exit..."},
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup {
	"tpope/vim-fugitive",
	"blazkowolf/gruber-darker.nvim",
	"savq/melange-nvim",
	"projekt0n/github-nvim-theme",
	"whonore/Coqtail",
	{
		"tikhomirov/vim-glsl",
		config = function()
			vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
				pattern = {"*.vs", "*.fs"},
				callback = function()
					vim.cmd([[set ft=glsl]])
				end
			})
		end
	},
	"tpope/vim-surround",
	"rose-pine/neovim",
	"rebelot/kanagawa.nvim",
	{
		"nvim-telescope/telescope.nvim", tag = "0.1.8",
		dependencies = {"nvim-lua/plenary.nvim"},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", word = { "vim%.uv" } },
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup {}
			lspconfig.pyright.setup {}
			lspconfig.ruff.setup {}
		end
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
	checker = {enabled = true},
}
