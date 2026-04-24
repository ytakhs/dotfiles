vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" }, { load = false })
vim.cmd.packadd("gitsigns.nvim")
require("gitsigns").setup({})
