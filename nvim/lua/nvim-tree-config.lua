local ok, nvim_tree = pcall(require, "nvim-tree");
if not ok then
	require("util").notify("require failed", "loading `nvim-tree` failed.", vim.log.levels.WARN);
	return;
end

nvim_tree.setup {
	renderer = {
		icons = {
			show = {git = false, folder = false, file = false, folder_arrow = true, modified = true}
		}
	}
};

local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree});

map_key("n", "<Leader>ft", ":NvimTreeToggle<CR>");
