vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
}, { load = false })

vim.cmd.packadd("nvim-web-devicons")
vim.cmd.packadd("lualine.nvim")
require("lualine").setup({
	sections = {
		lualine_c = {
			function()
				return vim.fn.getcwd()
			end,
		},
	},
})
