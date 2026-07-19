local M = {}

local warned = {}

---@param key string
---@param message string
function M.warn_once(key, message)
  if warned[key] then
    return
  end

  warned[key] = true
  vim.schedule(function()
    vim.notify(message, vim.log.levels.WARN, { title = "nvim4" })
  end)
end

---@param executable string
---@return boolean
function M.has(executable)
  return vim.fn.executable(executable) == 1
end

---@param executable string
---@param integration string
---@return boolean
function M.require_executable(executable, integration)
  if M.has(executable) then
    return true
  end

  M.warn_once(
    "executable:" .. executable .. ":" .. integration,
    ("%s disabled: executable `%s` was not found"):format(integration, executable)
  )
  return false
end

---@param executables string[]
---@param integration string
---@return boolean
function M.require_all(executables, integration)
  local missing = vim.iter(executables):filter(function(executable)
    return not M.has(executable)
  end):totable()

  if #missing == 0 then
    return true
  end

  M.warn_once(
    "executables:" .. integration,
    ("%s disabled: missing %s"):format(integration, table.concat(missing, ", "))
  )
  return false
end

---@param executables string[]
---@return string?
function M.first_available(executables)
  return vim.iter(executables):find(M.has)
end

return M
