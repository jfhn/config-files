local M = {}

local packages = require("config.packages")
local tools = require("config.tools")

local configured = false
local parsers = {}
local filetypes = {}
local custom_parsers = {}

local function setup()
  if configured then
    return require("nvim-treesitter")
  end

  packages.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
  local treesitter = require("nvim-treesitter")
  treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
  configured = true
  return treesitter
end

local function start(bufnr)
  local ok, err = pcall(vim.treesitter.start, bufnr)
  if not ok then
    tools.warn_once("treesitter:start:" .. vim.bo[bufnr].filetype, "Treesitter could not start: " .. tostring(err))
  end
end

local function refresh_autocmd()
  local group = vim.api.nvim_create_augroup("Nvim4Treesitter", { clear = true })
  local patterns = vim.tbl_keys(filetypes)
  table.sort(patterns)

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = patterns,
    callback = function(event)
      start(event.buf)
    end,
  })

  if filetypes[vim.bo.filetype] then
    start(vim.api.nvim_get_current_buf())
  end
end

---@param requested_parsers string[]
---@param requested_filetypes? string[]
function M.enable(requested_parsers, requested_filetypes)
  local treesitter = setup()
  local new_parsers = {}

  for _, parser in ipairs(requested_parsers) do
    if not parsers[parser] then
      parsers[parser] = true
      new_parsers[#new_parsers + 1] = parser
    end
  end

  for _, filetype in ipairs(requested_filetypes or requested_parsers) do
    filetypes[filetype] = true
  end

  refresh_autocmd()

  if #new_parsers > 0 and tools.require_all({ "curl", "tar", "tree-sitter", "cc" }, "Treesitter parser installation") then
    treesitter.install(new_parsers)
  end
end

---@param parser string
---@param definition table
function M.register_parser(parser, definition)
  setup()
  custom_parsers[parser] = definition

  local function register()
    require("nvim-treesitter.parsers")[parser] = custom_parsers[parser]
  end

  local group = vim.api.nvim_create_augroup("Nvim4TreesitterParser" .. parser, { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "TSUpdate",
    callback = register,
  })
  register()
end

return M
