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
	"d11wtq/subatomic256.vim",
	"MeanderingProgrammer/render-markdown.nvim",
	"whonore/Coqtail",
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration
			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua",              -- optional
			"echasnovski/mini.pick",         -- optional
		},
	},
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
	"lewis6991/gitsigns.nvim",
	{
		"nvim-telescope/telescope.nvim", tag = "0.1.8",
		dependencies = {"nvim-lua/plenary.nvim"},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
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
			lspconfig.tinymist.setup {
				settings = {
					formatterMode = "typstyle",
					exportPdf = "onType",
					semanticTokens = "disable",
				}
			}
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
	"gelguy/wilder.nvim",
	{
		'kaarmu/typst.vim',
		ft = 'typst',
		lazy=false,
	},
	{
		"chomosuke/typst-preview.nvim",
		lazy = false,
		opts = {},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- add any opts here
			-- for example
			provider = "openrouter",
			vendors = {
				openrouter = {
					__inherited_from = 'openai',
					endpoint = 'https://openrouter.ai/api/v1',
					api_key_name = 'OPENROUTER_API_KEY',
					model = 'deepseek/deepseek-r1',
				},
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		},
	},
	checker = {enabled = true},
}
