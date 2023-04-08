local ok, telescope = pcall(require, "telescope");
if not ok then
	require("util").warn("Telescope could not be found.");
	return;
end

telescope.setup {
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git",
			".idea",
			".vscode",
		}
	}
};

map_key("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>");
map_key("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>");
map_key("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>");
map_key("n", "<Leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>");
map_key("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>");
