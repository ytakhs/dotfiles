return {
	"stevearc/aerial.nvim",
	opts = {},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({})
	end,
}
