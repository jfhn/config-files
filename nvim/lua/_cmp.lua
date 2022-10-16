local util = require("util");

local ok, cmp = pcall(require, "cmp");
if not ok then
	util.notify("require failed", "loading `cmp` failed.", vim.log.levels.WARN);
	return;
end

local ok, luasnip = pcall(require, "luasnip");
if not ok then
	util.notify("require failed", "loading `luasnip` failed.", vim.log.levels.WARN);
	return;
end

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

	sources = cmp.config.sources({
		{name = "nvim_lsp"},
		{name = "luasnip"}
	}, {
		{name = "buffer"}
	}),

	experimental = {
		ghost_text = true
	}
};
