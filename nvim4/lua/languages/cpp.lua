local treesitter = require("config.treesitter")
local lsp = require("config.lsp")

treesitter.enable({ "c", "cpp" }, { "c", "cpp" })

lsp.enable("clangd", "clangd", {
  cmd = { "clangd", "--clang-tidy" },
})

return true
