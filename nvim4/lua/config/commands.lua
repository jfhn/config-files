local tools = require("config.tools")

vim.api.nvim_create_user_command("Make", function(command)
  if #command.fargs > 0 then
    vim.o.makeprg = table.concat(command.fargs, " ")
  end
  vim.cmd.make()
end, {
  nargs = "*",
  desc = "Set makeprg when provided, then run make",
})

vim.api.nvim_create_user_command("MakeTags", function()
  if tools.require_executable("ctags", "MakeTags") then
    vim.cmd("!ctags -R .")
  end
end, { desc = "Create a recursive tags file" })

local trim_group = "Nvim4TrimTrailingWhitespace"
local trim_on_save = false

local function strip_trailing_whitespace(bufnr)
  if vim.bo[bufnr].modifiable == false or vim.tbl_contains({ "TelescopePrompt", "qf" }, vim.bo[bufnr].filetype) then
    return
  end

  local view = vim.fn.winsaveview()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for index, line in ipairs(lines) do
    lines[index] = line:gsub("%s+$", "")
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.fn.winrestview(view)
end

vim.api.nvim_create_user_command("ToggleTrimOnSave", function()
  trim_on_save = not trim_on_save

  if trim_on_save then
    local group = vim.api.nvim_create_augroup(trim_group, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      callback = function(event)
        strip_trailing_whitespace(event.buf)
      end,
    })
  else
    pcall(vim.api.nvim_del_augroup_by_name, trim_group)
  end

  vim.notify("Trim on save: " .. (trim_on_save and "ON" or "OFF"))
end, { desc = "Toggle trailing whitespace removal on save" })
