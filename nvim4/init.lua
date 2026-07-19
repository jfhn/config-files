if vim.fn.has("nvim-0.12") ~= 1 then
  error("nvim4 requires Neovim 0.12 or newer")
end

local source = assert(debug.getinfo(1, "S").source:match("^@(.+)$"))
local config_dir = vim.fn.fnamemodify(source, ":p:h")
if not vim.list_contains(vim.api.nvim_list_runtime_paths(), config_dir) then
  vim.opt.runtimepath:prepend(config_dir)
end

require("config.settings")
require("config.plugins")
require("config.mappings")
require("config.commands")

local local_config = config_dir .. "/local.lua"

if vim.uv.fs_stat(local_config) then
  dofile(local_config)
end
