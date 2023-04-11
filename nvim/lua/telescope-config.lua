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
