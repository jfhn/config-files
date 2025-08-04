vim.cmd('source ' .. vim.fn.stdpath('config') .. '/minimal.vim')
vim.o.winborder = 'none'  -- Any other setting conflicts with wilder menu :(

vim.pack.add {
  -- Base
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/echasnovski/mini.pick',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/tpope/vim-surround.git',
  'https://github.com/gelguy/wilder.nvim',

  -- Git
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/NeogitOrg/neogit.git',

  -- Themes
  'https://github.com/blazkowolf/gruber-darker.nvim',
}

require('mini.pick').setup {}
require('oil').setup {}
require('neogit').setup { kind = 'split_above' }
local wilder = require('wilder')
wilder.setup { modes = { ':', '/', '?' } }
wilder.set_option('renderer', wilder.wildmenu_renderer {
  highlighter = wilder.basic_highlighter(),
})

vim.lsp.enable { 'lua_ls', 'pyright' }

vim.g.mapleader = ' '
local map = vim.keymap.set
map('n', '<leader>=', vim.lsp.buf.format)
map('n', '<leader>ff', ':Pick files<CR>')
map('n', '<leader>fg', ':Pick grep_live<CR>')
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>gg', ':Neogit<CR>')

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.lua', '*.js', '*.ts', '*.ml' },
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
vim.cmd('hi link MiniPickNormal Normal')  -- Fix invisible selection.
