local ok, lspconfig = pcall(require, "lspconfig");
if not ok then
	util.notify("Require failed", "loading `lspconfig` failed.", vim.log.levels.WARN);
	return;
end

for server, setup in pairs(LSP_Servers) do
	lspconfig[server].setup(setup);
end

local lsp_lines
ok, lsp_lines = pcall(require, "lsp_lines")
if not ok then
	util.notify("Require failed", "loading `lsp_lines` failed.", vim.log.levels.WARN)
	return
end

local show_lsp_message_multiline = false

toggle_lsp_message_multiline = function()
	show_lsp_message_multiline = not show_lsp_message_multiline
	vim.diagnostic.config {virtual_text = not show_lsp_message_multiline}
	lsp_lines.toggle()
end

lsp_lines.setup()
lsp_lines.toggle()
vim.keymap.set("n", "<C-l>", toggle_lsp_message_multiline, {desc = "Toggle lsp_lines"})

print("Lsp configured")
