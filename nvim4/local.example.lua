-- Copy this file to local.lua and uncomment only the modules you want.
-- local.lua is intentionally ignored by Git.

-- C/C++: clangd. Uses compile_commands.json, .clang-tidy, and .clang-format.
-- require("languages.cpp")

-- Haskell: haskell-language-server-wrapper.
-- require("languages.haskell")

-- Lean: lake or lean. Parser installation also needs the common tools below.
-- require("languages.lean")

-- Lua: lua-language-server.
-- require("languages.lua")

-- OCaml: ocamllsp.
-- require("languages.ocaml")

-- Python: pyright-langserver.
-- require("languages.python")

-- Rust: rust-analyzer.
-- require("languages.rust")

-- Typst: tinymist; preview additionally needs websocat.
-- require("languages.typst")

-- JavaScript/TypeScript: typescript-language-server.
-- require("languages.typescript")

-- AI: opencode is needed for the OpenCode integration; nvim-vibe is standalone.
-- require("features.ai")

-- Extra Git search: git and a GitHub remote for :GBrowse.
-- require("features.git_extra")

-- Cursor Light theme setup.
-- require("features.cursor")

-- Parser installation for every language needs curl, tar, tree-sitter, and cc.

-- Optional theme customization (run after module requires):
-- vim.o.background = "dark"
-- vim.cmd.colorscheme("melange")
-- vim.cmd.highlight("Normal guibg=none")

-- Optional status-column customization:
-- vim.o.statuscolumn = "%s %l %#LineNrSeparator#│ %*"
-- vim.api.nvim_set_hl(0, "LineNrSeparator", { fg = "#E0E0E0" })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#999999" })
