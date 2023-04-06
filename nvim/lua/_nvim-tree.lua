local ok, nvim_tree = pcall(require, "nvim-tree");
if not ok then
	require("util").notify("reuire failed", "loading `nvim-tree` failed.", vim.log.levels.WARN);
	return;
end

nvim_tree.setup();

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree});
