local M = {}

local enabled = {}
local attach_group = vim.api.nvim_create_augroup("Nvim4LspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = attach_group,
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local opts = { buffer = event.buf, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP definition" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP declaration" }))
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP rename" }))
    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP code action" }))
    vim.keymap.set("n", "<leader>=", function()
      vim.lsp.buf.format({ bufnr = event.buf, async = false })
    end, vim.tbl_extend("force", opts, { desc = "LSP format" }))
    vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, vim.tbl_extend("force", opts, { desc = "LSP completion" }))

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
})

vim.opt.completeopt:append({ "menuone", "noselect", "popup" })

---@param name string
---@param executable string
---@param config? vim.lsp.Config
---@return boolean
function M.enable(name, executable, config)
  if enabled[name] then
    return true
  end

  if not require("config.tools").require_executable(executable, name .. " LSP") then
    return false
  end

  vim.lsp.config(name, config or {})
  vim.lsp.enable(name)
  enabled[name] = true
  return true
end

return M
