local packages = require("config.packages")
local tools = require("config.tools")

require("config.treesitter").enable({ "typst" })
require("config.lsp").enable("tinymist", "tinymist")

packages.add({ "https://github.com/chomosuke/typst-preview.nvim" })

if tools.require_all({ "tinymist", "websocat" }, "Typst Preview") then
  require("typst-preview").setup({
    dependencies_bin = {
      tinymist = vim.fn.exepath("tinymist"),
      websocat = vim.fn.exepath("websocat"),
    },
  })
end

return true
