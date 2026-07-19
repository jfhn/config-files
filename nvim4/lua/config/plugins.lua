local packages = require("config.packages")

packages.add({
  -- Core editor tools.
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/tpope/vim-surround.git",
  "https://github.com/gelguy/wilder.nvim",
  "https://github.com/vimpostor/vim-tpipeline",
  "https://github.com/NeogitOrg/neogit.git",
  "https://github.com/tpope/vim-fugitive.git",

  -- Themes from nvim3. Cursor Light is opt-in through features.cursor.
  "https://github.com/blazkowolf/gruber-darker.nvim",
  "https://github.com/projekt0n/github-nvim-theme",
  "https://github.com/savq/melange-nvim",
  "https://github.com/rose-pine/neovim.git",
  "https://github.com/shaunsingh/nord.nvim",
  "https://github.com/dgrco/deepwater.nvim",
  "https://github.com/phha/zenburn.nvim",
  "https://github.com/Shatur/neovim-ayu",
  "https://github.com/maxmx03/solarized.nvim",
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/ydkulks/cursor-dark.nvim",
})

require("oil").setup({
  default_file_explorer = true,
  columns = { "icon", "permissions", "user", "group", "size", "mtime" },
  win_options = {
    signcolumn = "no",
    cursorcolumn = false,
    spell = false,
  },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = false,
  prompt_save_on_select_new_entry = true,
  lsp_file_methods = {
    enabled = false,
    autosave_changes = false,
  },
  watch_for_changes = true,
  use_default_keymaps = true,
  view_options = { show_hidden = true },
})

require("telescope").setup({})
require("neogit").setup({})

local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option("renderer", wilder.wildmenu_renderer({
  highlighter = wilder.basic_highlighter(),
}))

vim.cmd.colorscheme("rose-pine")
vim.cmd.highlight("Normal guibg=none")
