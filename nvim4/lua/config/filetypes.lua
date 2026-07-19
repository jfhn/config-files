local M = {}

---@param name string
---@param patterns string[]
---@param options table<string, any>
function M.options(name, patterns, options)
  local group = vim.api.nvim_create_augroup("Nvim4Filetype" .. name, { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = patterns,
    callback = function(event)
      for option, value in pairs(options) do
        vim.bo[event.buf][option] = value
      end
    end,
  })

  if vim.tbl_contains(patterns, vim.bo.filetype) then
    for option, value in pairs(options) do
      vim.bo[option] = value
    end
  end
end

return M
