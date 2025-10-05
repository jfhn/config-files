vim.cmd('source ' .. vim.fn.stdpath('config') .. '/minimal.vim')
vim.o.winborder = 'none'  -- Any other setting conflicts with wilder menu :(

vim.pack.add {
  -- Base
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/tpope/vim-surround.git',
  'https://github.com/gelguy/wilder.nvim',
  'https://github.com/chomosuke/typst-preview.nvim',

  -- Git
  'https://github.com/NeogitOrg/neogit.git',

  -- Themes
  'https://github.com/blazkowolf/gruber-darker.nvim',
  'https://github.com/projekt0n/github-nvim-theme',
  'https://github.com/savq/melange-nvim',
  'https://github.com/rose-pine/neovim.git',
  'https://github.com/shaunsingh/nord.nvim',
}

require('oil').setup {
  default_file_explorer = true,

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
require('neogit').setup { kind = 'split_above' }
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

vim.lsp.enable { 'lua_ls', 'pyright', 'tinymist', 'ts_ls', 'ols' }

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

dofile(vim.fn.stdpath('config') .. '/local.lua')
