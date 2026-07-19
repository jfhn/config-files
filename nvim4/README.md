# nvim4

`nvim4` is a standalone Neovim 0.12+ configuration. Its default startup is
language-neutral: it installs the core editor plugins and themes, but no
Treesitter parser, language server, or language-specific plugin.

Activation and symlinking are intentionally manual. Copy `local.example.lua`
to `local.lua`, then uncomment the modules you want. `local.lua` is loaded
synchronously after the core configuration. A real error in that file stops
startup with the original traceback instead of being silently ignored.

## Language modules

Every language module installs its own Neovim dependencies, enables its own
parsers, and enables its LSP only when the server executable is available.
Missing executables emit one warning and do not stop startup.

| Module | Parsers | Required executable |
| --- | --- | --- |
| `languages.cpp` | C, C++ | `clangd` |
| `languages.haskell` | Haskell | `haskell-language-server-wrapper` |
| `languages.lean` | Lean | `lake` or `lean` |
| `languages.lua` | Lua | `lua-language-server` |
| `languages.ocaml` | OCaml implementation/interface | `ocamllsp` |
| `languages.python` | Python | `pyright-langserver` |
| `languages.rust` | Rust | `rust-analyzer` |
| `languages.typst` | Typst | `tinymist`; `websocat` for preview |
| `languages.typescript` | JavaScript, TypeScript, TSX | `typescript-language-server` |

Installing any parser also requires system-managed `curl`, `tar`,
`tree-sitter`, and a C compiler available as `cc`. Parser installation is
asynchronous. Opening a matching file activates its parser once installed.

The C/C++ module starts `clangd --clang-tidy`. Clangd discovers project roots
and project configuration using its standard LSPConfig markers, including
`compile_commands.json`, `.clangd`, `.clang-tidy`, and `.clang-format`.
Diagnostics, clang-tidy code actions, native completion, and synchronous LSP
formatting (`<leader>=`) are available after attachment. Formatting therefore
uses the project's `.clang-format` configuration without a separate formatting
plugin.

## Feature modules

| Module | Contents | Required executable |
| --- | --- | --- |
| `features.ai` | nvim-vibe and OpenCode | `opencode` for OpenCode only |
| `features.git_extra` | Advanced Git Search and Vim Rhubarb | `git` |
| `features.cursor` | Cursor Light setup | none |

These plugins are absent from the initial package lock and are neither
installed nor configured until their module is required.

## Customization

All themes from `nvim3` remain available, with Cursor Light installed through
`features.cursor`. The default is Rose Pine. Theme and status-column examples
are included at the bottom of `local.example.lua`; put customizations after
module requires so they win over module setup.

Plugin revisions live in this directory's `nvim-pack-lock.json`. Native
`vim.pack` updates that lock when an opt-in module introduces another package.
