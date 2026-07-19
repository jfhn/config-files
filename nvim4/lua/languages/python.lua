require("config.treesitter").enable({ "python" })
require("config.filetypes").options("Python", { "python" }, {
  expandtab = true,
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
})
require("config.lsp").enable("pyright", "pyright-langserver")

return true
