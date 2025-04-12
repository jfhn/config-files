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
-- 	{
-- 		"yetone/avante.nvim",
-- 		event = "VeryLazy",
-- 		version = false, -- Never set this value to "*"! Never!
-- 		opts = {
-- 			-- add any opts here
-- 			-- for example
-- 			provider = "openai",
-- 			openai = {
-- 				endpoint = "https://api.openai.com/v1",
-- 				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
-- 				timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
-- 				temperature = 0,
-- 				max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
-- 				--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
-- 			},
-- 		},
-- 		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
-- 		build = "make",
-- 		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
-- 		dependencies = {
-- 			"nvim-treesitter/nvim-treesitter",
-- 			"stevearc/dressing.nvim",
-- 			"nvim-lua/plenary.nvim",
-- 			"MunifTanjim/nui.nvim",
-- 			--- The below dependencies are optional,
-- 			"echasnovski/mini.pick", -- for file_selector provider mini.pick
-- 			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
-- 			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
-- 			"ibhagwan/fzf-lua", -- for file_selector provider fzf
-- 			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
-- 			"zbirenbaum/copilot.lua", -- for providers='copilot'
-- 			{
-- 				-- support for image pasting
-- 				"HakonHarnes/img-clip.nvim",
-- 				event = "VeryLazy",
-- 				opts = {
-- 					-- recommended settings
-- 					default = {
-- 						embed_image_as_base64 = false,
-- 						prompt_for_file_name = false,
-- 						drag_and_drop = {
-- 							insert_mode = true,
-- 						},
-- 						-- required for Windows users
-- 						use_absolute_path = true,
-- 					},
-- 				},
-- 			},
-- 			{
-- 				-- Make sure to set this up properly if you have lazy=true
-- 				'MeanderingProgrammer/render-markdown.nvim',
-- 				opts = {
-- 					file_types = { "markdown", "Avante" },
-- 				},
-- 				ft = { "markdown", "Avante" },
-- 			},
-- 		},
-- 	},
	checker = {enabled = true},
}
