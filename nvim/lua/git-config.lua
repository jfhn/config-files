local ok, gitsigns = pcall(require, "gitsigns");
if not ok then
	require("util").warn("gitsigns could not be loaded.");
	return;
end

gitsigns.setup {
	signcolumn = true,
};
