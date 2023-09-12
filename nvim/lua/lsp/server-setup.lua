--- @param scope "line"|"buffer"
local function lsp_list_diagnostics(scope)
	-- Copied from: https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/lsp/config.lua
	local float = vim.diagnostic.config().float;

	if float then
		local config = type(float) == "table" and float or {};
		config.scope = scope;

		vim.diagnostic.open_float(config);
	end
end

local function lsp_list_diagnostics_line()
	lsp_list_diagnostics("line");
end

local function lsp_list_workspace_folders()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()));
end

local lsp_keymap = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr };
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts);
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts);
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts);
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts);
	vim.keymap.set('n', '<C-?>', vim.lsp.buf.signature_help, bufopts);
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts);
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts);
	vim.keymap.set('n', '<space>wl', lsp_list_workspace_folders, bufopts);
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts);
	vim.keymap.set('n', 'gw', vim.lsp.buf.document_symbol, bufopts);
	vim.keymap.set('n', 'gW', vim.lsp.buf.workspace_symbol, bufopts);
	vim.keymap.set('n', '<space>dl', lsp_list_diagnostics_line, bufopts);
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts);
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts);
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts);
	vim.keymap.set('n', '<space>=', function() vim.lsp.buf.format { async = true } end, bufopts);
	vim.keymap.set('n', '<space>da', "<cmd>LspTroubleToggle workspace_diagnostics<cr>", bufopts);
	vim.keymap.set('n', '<space>db', "<cmd>LspTroubleToggle document_diagnostics<cr>", bufopts);
	-- vim.keymap.set('n', '<space>dn', ":cn", bufopts);
	-- vim.keymap.set('n', '<space>dl', function() vim.lsp.diagnostic.goto_prev() end, bufopts);

	vim.keymap.set("n", "<leader>ws", function()
		require("metals").hover_worksheet()
	end)

	-- all workspace diagnostics
	vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist)

	-- all workspace errors
	vim.keymap.set("n", "<leader>ae", function()
		vim.diagnostic.setqflist({ severity = "E" })
	end)

	-- all workspace warnings
	vim.keymap.set("n", "<leader>aw", function()
		vim.diagnostic.setqflist({ severity = "W" })
	end)

	-- buffer diagnostics only
	vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)

	vim.keymap.set("n", "[c", function()
		vim.diagnostic.goto_prev({ wrap = false })
	end)

	vim.keymap.set("n", "]c", function()
		vim.diagnostic.goto_next({ wrap = false })
	end)

	print("LSP keymap has been set.")
end

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc');
	lsp_keymap(client, bufnr);
end

LSP_Servers = {
	lua_ls = {
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim", "vim.api" }
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					-- library = {
					-- 	[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					-- 	[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					-- 	[vim.fn.stdpath("config") .. "/lua"] = true,
					-- }
				},
				telemetry = {
					enable = false
				}
			}
		}
	},

	rust_analyzer = {
		on_attach = on_attach,
		cmd = {"rustup", "run", "stable", "rust-analyzer"},
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = {"cargo", "clippy"},
				},
			},
		},
	},
};


-- Metals configuration.

local util = require("util");
local ok, metals_config = pcall(require, "metals");
if not ok then
	util.notify("Require failed", "loading `metals` failed.", vim.log.levels.WARN)
	return
end

metals_config = require("metals").bare_config()
metals_config.settings = {
	showImplicitArguments = true,
	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
metals_config.init_options.statusBarProvider = "on"

metals_config.on_attach = lsp_keymap

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	-- NOTE: You may or may not want java included here. You will need it if you
	-- want basic Java support but it may also conflict if you are using
	-- something like nvim-jdtls which also works on a java filetype autocmd.
	pattern = { "scala", "sbt" },
	callback = function()
		require("metals").initialize_or_attach(metals_config)
	end,
	group = nvim_metals_group,
})
