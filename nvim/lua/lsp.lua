local cmp     = require("cmp");
local luasnip = require("luasnip");

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args);
		end
	},

	mapping = {
		["<C-k>"]     = cmp.mapping.select_prev_item(),
		["<C-j>"]     = cmp.mapping.select_next_item(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-g>"]     = cmp.mapping.abort(),
		["<CR>"]      = cmp.mapping.confirm {select = true},
		["<TAB>"]     = cmp.mapping.confirm {select = true},
	},

	formatting = {
		fields = {"abbr", "menu"},
	},

	sources = {
		cmp.config.sources({
			{name = "nvim_lsp"},
			{name = "luasnip"}
		}, {
			{name = "buffer"}
		})
	},

	experimental = {
		ghost_text = true
	}
};

local debug = require("_debug");
debug.print(cmp.setup);

print("module loaded: lsp");
