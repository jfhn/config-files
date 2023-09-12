local util = require("util");

local ok = pcall(require, "lspconfig");
if not ok then
	util.notify("require failed", "loading `lspconfig` failed.", vim.log.levels.WARN);
	return
end

require("lsp.trouble-setup");
require("lsp.server-setup");
require("lsp.lsp-installer");
require("lsp.lsp-config");
