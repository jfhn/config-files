vim.g.mapleader = " "

vim.o.winborder = "none"
vim.o.background = "dark"
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.backspace = "indent,eol,start"
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·" }
vim.o.ruler = true
vim.o.belloff = "all"
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.scrolloff = 5
vim.o.cursorline = true
vim.o.lazyredraw = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.synmaxcol = 300
vim.o.autoread = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.undofile = true
vim.o.fileformats = "unix"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.foldmethod = "marker"
vim.opt.path:append("**")

vim.g.netrw_banner = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --vimgrep --smart-case --hidden"
  vim.o.grepformat = "%f:%l:%c:%m"
end

vim.cmd.syntax("enable")
