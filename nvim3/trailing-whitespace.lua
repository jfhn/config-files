local M = {
  trim_on_save = false,
}

function M.strip_trailing_whitespace()
  local filetype = vim.bo.filetype
  local exclude = { TelescopePrompt = true, qf = true }

  if exclude[filetype] then
    return
  end

  local view = vim.fn.winsaveview()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    lines[i] = vim.fn.substitute(line, [[\s\+$]], "", "g")
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.fn.winrestview(view)
end

function M.toggle_trim_on_save()
  M.trim_on_save = not M.trim_on_save

  if M.trim_on_save then
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        M.strip_trailing_whitespace()
      end,
      group = vim.api.nvim_create_augroup("TrimTrailingWhitespace", { clear = true }),
    })
    vim.notify("Trim on save: ON", vim.log.levels.INFO)
  else
    pcall(vim.api.nvim_del_augroup_by_name, "TrimTrailingWhitespace")
    vim.notify("Trim on save: OFF", vim.log.levels.INFO)
  end
end

vim.api.nvim_create_user_command("ToggleTrimOnSave", M.toggle_trim_on_save, {})

return M