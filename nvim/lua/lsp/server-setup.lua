local lsp_keymap = function(bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = {noremap = true, silent = true, buffer = bufnr};
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts);
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts);
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts);
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts);
	vim.keymap.set('n', '<C-?>', vim.lsp.buf.signature_help, bufopts);
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts);
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts);
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()));
	end, bufopts);
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts);
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts);
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts);
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts);
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts);
end

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc');

	lsp_keymap(bufnr);
end

LSP_Servers = {
	sumneko_lua = {
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = {"vim"}
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

require("flutter-tools").setup{};
