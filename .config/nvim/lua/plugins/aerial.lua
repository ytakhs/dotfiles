vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/aerial.nvim",
}, { load = false })

vim.cmd.packadd("nvim-web-devicons")
vim.cmd.packadd("aerial.nvim")
require("aerial").setup({})
