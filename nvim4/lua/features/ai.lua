local packages = require("config.packages")
local tools = require("config.tools")

packages.add({
  { src = "https://github.com/jfhn/nvim-vibe", version = "plan/v2" },
  "https://github.com/nickjvandyke/opencode.nvim",
})

require("nvim-vibe").setup({})

vim.keymap.set("n", "<leader>vp", "<Cmd>Telescope nvim-vibe<CR>", { desc = "Vibe projects" })
vim.keymap.set("n", "<leader>vs", "<Cmd>NvimVibe sidebar<CR>", { desc = "Vibe sidebar" })

if tools.require_executable("opencode", "OpenCode") then
  vim.g.opencode_opts = vim.g.opencode_opts or {}
  vim.api.nvim_create_user_command("OpenCode", function()
    require("opencode").toggle()
  end, { force = true, desc = "Toggle OpenCode" })
  vim.keymap.set("x", "<C-l>", function()
    require("opencode").ask("@this: ")
  end, { desc = "Add selection to OpenCode prompt" })
end

return true
