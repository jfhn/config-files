local packages = require("config.packages")
local tools = require("config.tools")
local treesitter = require("config.treesitter")

packages.add({ "https://github.com/Julian/lean.nvim" })

treesitter.register_parser("lean", {
  install_info = {
    url = "https://github.com/Julian/tree-sitter-lean",
  },
})
treesitter.enable({ "lean" }, { "lean" })

local lean_executable = tools.first_available({ "lake", "lean" })
if not lean_executable then
  tools.warn_once("lean:lsp", "Lean LSP disabled: neither `lake` nor `lean` was found")
end

require("lean").setup({
  mappings = true,
  lsp = { enable = lean_executable ~= nil },
})

return true
