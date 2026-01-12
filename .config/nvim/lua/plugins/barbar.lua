return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	version = "^1.0.0",
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		animation = true,
	},
	keys = {
		{ "<leader>bn", ":BufferNext<CR>", desc = "Next buffer" },
		{ "<leader>bp", ":BufferPrevious<CR>", desc = "Previous buffer" },
		{ "<leader>bc", ":BufferClose<CR>", desc = "Close buffer" },
		{ "<leader>br", ":BufferRestore<CR>", desc = "Restore buffer" },
	},
}
