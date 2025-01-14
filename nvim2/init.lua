require("local")

vim.cmd("source " .. vim.fn.stdpath("config") .. "/minimal.vim")

require("config")
require("util")

vim.cmd("colo gruber-darker")
vim.cmd("hi String gui=none")
vim.cmd("hi Comment gui=none")
