local util = require("util");

local ok = pcall(require, "lspconfig");
if not ok then
	util.notify("require failed", "loading `lspconfig` failed.", vim.log.levels.WARN);
	return
end

require("lsp.lsp-installer");
