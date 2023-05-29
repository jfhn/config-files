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

local function lsp_list_diagnostics_buffer()
	lsp_list_diagnostics("buffer");
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
	vim.keymap.set('n', 'gl', lsp_list_diagnostics_line, bufopts);
	vim.keymap.set('n', 'ga', lsp_list_diagnostics_buffer, bufopts);
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts);
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts);
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts);
	vim.keymap.set('n', '<space>=', function() vim.lsp.buf.format { async = true } end, bufopts);
end

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
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
					globals = { "vim" }
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					}
				}
			}
		}
	},

	vimls = {
		on_attach = on_attach
	},

	pyright = {
		on_attach = on_attach
	},

	tsserver = {
		on_attach = on_attach
	},

	rust_analyzer = {
		on_attach = on_attach
	},

	clangd = {
		on_attach = on_attach
	}
};
