require("config.treesitter").enable(
  { "javascript", "typescript", "tsx" },
  { "javascript", "javascriptreact", "typescript", "typescriptreact" }
)
require("config.filetypes").options(
  "TypeScript",
  { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  {
    expandtab = true,
    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 2,
  }
)
require("config.lsp").enable("ts_ls", "typescript-language-server")

return true
