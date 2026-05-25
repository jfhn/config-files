vim.o.winborder = 'none'  -- Any other setting conflicts with wilder menu :(

vim.pack.add {
  -- Base
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  { src = 'https://github.com/jfhn/oil.nvim', branch = 'user-group-columns' },
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/tpope/vim-surround.git',
  'https://github.com/gelguy/wilder.nvim',
  'https://github.com/chomosuke/typst-preview.nvim',
  'https://github.com/vimpostor/vim-tpipeline',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  { src = 'https://github.com/jfhn/nvim-vibe', version = 'plan/v2' },

  -- Git
  'https://github.com/NeogitOrg/neogit.git',
  'https://github.com/tpope/vim-fugitive.git',
  'https://github.com/tpope/vim-rhubarb.git',
  'https://github.com/aaronhallaert/advanced-git-search.nvim',

  -- Themes
  'https://github.com/blazkowolf/gruber-darker.nvim',
  'https://github.com/projekt0n/github-nvim-theme',
  'https://github.com/savq/melange-nvim',
  'https://github.com/rose-pine/neovim.git',
  'https://github.com/shaunsingh/nord.nvim',
  'https://github.com/dgrco/deepwater.nvim',
  'https://github.com/phha/zenburn.nvim',
  'https://github.com/Shatur/neovim-ayu',
  'https://github.com/maxmx03/solarized.nvim',
  'https://github.com/ellisonleao/gruvbox.nvim',
  'https://github.com/ydkulks/cursor-dark.nvim',
  'https://github.com/vpoltora/cursor-light.nvim',

  -- AI
  'https://github.com/nickjvandyke/opencode.nvim',

  -- Language Support
  'https://github.com/Julian/lean.nvim',
}

require('nvim-vibe').setup {}
require('oil').setup {
  default_file_explorer = true,

  columns = {
    "icon",
    "permissions",
    "user",
    "group",
    "size",
    "mtime",
  },

  win_options = {
    signcolumn = 'no',
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

  view_options = {
    show_hidden = true
  },
}
local wilder = require('wilder')
wilder.setup { modes = { ':', '/', '?' } }
wilder.set_option('renderer', wilder.wildmenu_renderer {
  highlighter = wilder.basic_highlighter(),
})
require('typst-preview').setup {
  dependencies_bin = {
    ['tinymist'] = '/home/jan/.local/bin/tinymist'
  }
}
require('telescope').setup {
  extensions = {
    advanced_git_search = {
      {
        -- Browse command to open commits in browser. Default fugitive GBrowse.
        -- {commit_hash} is the placeholder for the commit hash.
        browse_command = "GBrowse {commit_hash}",
        -- when {commit_hash} is not provided, the commit will be appended to the specified command seperated by a space
        -- browse_command = "GBrowse",
        -- => both will result in calling `:GBrowse commit`

        -- fugitive or diffview
        diff_plugin = "fugitive",
        -- customize git in previewer
        -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
        git_flags = {},
        -- customize git diff in previewer
        -- e.g. flags such as { "--raw" }
        git_diff_flags = {},
        git_log_flags = {},
        -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
        show_builtin_git_pickers = false,
        entry_default_author_or_date = "author", -- one of "author", "date" or "both"
        keymaps = {
          -- following keymaps can be overridden
          toggle_date_author = "<C-w>",
          open_commit_in_browser = "<C-o>",
          copy_commit_hash = "<C-y>",
          show_entire_commit = "<C-e>",
        },

        -- Telescope layout setup
        telescope_theme = {
          function_name_1 = {
              -- Theme options
          },
          function_name_2 = "dropdown",
          -- e.g. realistic example
          show_custom_functions = {
            layout_config = { width = 0.4, height = 0.4 },
          },
        }
      }
    }
  }
}
require('lean').setup { mappings = true }
require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require('nvim-treesitter').install { 'rust', 'typescript', 'javascript', 'lua', 'c', 'cpp', 'ocaml', 'haskell', 'python' }
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'lua', 'javascript' },
  callback = function() vim.treesitter.start() end,
})

vim.lsp.config('*', {})
vim.lsp.enable { 'lua_ls', 'pyright', 'tinymist', 'ts_ls', 'ols', 'rust-analyzer', 'hls' }

vim.g.mapleader = ' '
local map = vim.keymap.set
map('n', '<leader>=', vim.lsp.buf.format)
map('n', '<leader>ff', ':lua require("telescope.builtin").find_files({hidden = true})<CR>')
map('n', '<leader>fg', ':Telescope live_grep<CR>')
map('n', '<leader>fs', ':Telescope grep_string<CR>')
map('n', '<leader>b', ':Telescope buffers<CR>')
map('n', '<leader>h', ':Telescope help_tags<CR>')
map('n', '<leader>gg', ':Neogit<CR>')
map('n', '<leader>e', ':Oil .<CR>')
map('n', '<leader>vp', ':Telescope nvim-vibe<CR>')
map('n', '<leader>vs', ':NvimVibe sidebar<CR>')

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.js', '*.ts', '*.ml' },
  callback = function()
    vim.cmd('set ts=2 sts=2 sw=2 et')
  end
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.py' },
  callback = function()
    vim.cmd('set et')
  end
})

---@param command table
function Make(command)
  if #command.fargs > 0 then
    local cmd = ''
    for _, c in ipairs(command.fargs) do
      cmd = cmd .. '\\ ' .. c
    end
    vim.cmd('set makeprg=' .. cmd)
  end
  vim.cmd('make')
end

vim.api.nvim_create_user_command('Make', Make, {
  nargs = '*',
  desc = 'Updates make program if specified and executes it',
})

-- OpenCode config
vim.api.nvim_create_user_command('OpenCode', function()
  require("opencode").toggle()
end, {})
vim.keymap.set('x', '<C-l>', function()
  require("opencode").ask("@this: ")
end, { desc = "Add selection to OpenCode prompt" })

vim.cmd('source ' .. vim.fn.stdpath('config') .. '/minimal.vim')
vim.defer_fn(function()
  dofile(vim.fn.stdpath('config') .. '/local.lua')
  require('neogit').setup {}
  pcall(dofile, vim.fn.stdpath('config') .. '/trailing-whitespace.lua')
  -- For some reason, some settings are overwritten from minimal.vim and we
  -- need to set them again manually.
  vim.o.ruler = true
end, 0)
