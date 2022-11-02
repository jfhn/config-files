local ok, lspconfig = pcall(require, "lspconfig");
if not ok then
	util.notify("require failed", "loading `lspconfig` failed.", vim.log.levels.WARN);
	return;
end

for server, setup in pairs(LSP_Servers) do
	lspconfig[server].setup(setup);
end
