require("config.treesitter").enable(
  { "ocaml", "ocaml_interface" },
  { "ocaml", "ocamlinterface" }
)
require("config.lsp").enable("ocamllsp", "ocamllsp")

return true
