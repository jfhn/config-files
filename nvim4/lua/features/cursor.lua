require("config.packages").add({ "https://github.com/vpoltora/cursor-light.nvim" })

require("cursor-light").setup({
  ui = false,
  integrations = {
    lspsaga = false,
    nvim_tree = false,
    barbar = false,
  },
})

return true
