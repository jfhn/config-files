local util = require("util");

local ok, installer = pcall(require, "nvim-lsp-installer");
if not ok then
	util.notify("require failed", "loading `nvim-lsp-installer` failed.", vim.log.levels.WARN);
	return
end

installer.setup {
	ensure_installed = {
		"sumneko_lua",
		"vimls"
	}
};
