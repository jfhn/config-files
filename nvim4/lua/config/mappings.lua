local map = vim.keymap.set

map("n", "<C-h>", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<C-l>", "<Cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ hidden = true })
end, { desc = "Find files" })
map("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fs", "<Cmd>Telescope grep_string<CR>", { desc = "Grep word" })
map("n", "<leader>b", "<Cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>h", "<Cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>gg", "<Cmd>Neogit<CR>", { desc = "Neogit" })
map("n", "<leader>e", "<Cmd>Oil .<CR>", { desc = "File explorer" })
