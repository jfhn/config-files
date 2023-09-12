--- @param mode "n"|"i"|"v"
--- @param keys string
--- @param action string
--- @param opts table|nil
map_key = function(mode, keys, action, opts)
	local options = {noremap = true};
	if opts then
		options = vim.tbl_extend("force", options, opts);
	end
	vim.api.nvim_set_keymap(mode, keys, action, options);
end

require("ui");
require("editor");
require("_cmp");
require("lsp");
require("telescope-config");
require("git-config");
require("nvim-tree-config");
require("vimtex-config");
require("on-save-runner");
