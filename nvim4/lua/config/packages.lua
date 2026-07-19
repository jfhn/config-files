local M = {}

local added = {}

local function name(spec)
  if type(spec) == "table" and spec.name then
    return spec.name
  end

  local src = type(spec) == "table" and spec.src or spec
  return src:match("/([^/]+)%.git$") or src:match("/([^/]+)$")
end

---Add and load packages once per Neovim session.
---@param specs (string|vim.pack.Spec)[]
function M.add(specs)
  local missing = {}

  for _, spec in ipairs(specs) do
    local package_name = assert(name(spec), "package specification has no name")
    if not added[package_name] then
      added[package_name] = true
      missing[#missing + 1] = spec
    end
  end

  if #missing > 0 then
    vim.pack.add(missing, { confirm = false, load = true })
  end
end

return M
