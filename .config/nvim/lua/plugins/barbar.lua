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
	config = function()
		require("barbar").setup({
			animation = true,
		})

		vim.keymap.set("n", "<leader>bn", ":BufferNext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<leader>bp", ":BufferPrevious<CR>", { desc = "Previous buffer" })
		vim.keymap.set("n", "<leader>bc", ":BufferClose<CR>", { desc = "Close buffer" })
		vim.keymap.set("n", "<leader>br", ":BufferRestore<CR>", { desc = "Restore buffer" })
	end,
}
