require("config.treesitter").enable({ "haskell" }, { "haskell", "lhaskell" })
require("config.lsp").enable("hls", "haskell-language-server-wrapper")

return true
