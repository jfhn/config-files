require("config.packages").add({
  "https://github.com/aaronhallaert/advanced-git-search.nvim",
  "https://github.com/tpope/vim-rhubarb.git",
})

require("telescope").setup({
  extensions = {
    advanced_git_search = {
      diff_plugin = "fugitive",
      browse_command = "GBrowse {commit_hash}",
      show_builtin_git_pickers = false,
      entry_default_author_or_date = "author",
    },
  },
})
require("telescope").load_extension("advanced_git_search")

return true
