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
		{ "<leader>b1", ":BufferGoto 1<CR>", desc = "Go to buffer 1" },
		{ "<leader>b2", ":BufferGoto 2<CR>", desc = "Go to buffer 2" },
		{ "<leader>b3", ":BufferGoto 3<CR>", desc = "Go to buffer 3" },
		{ "<leader>b4", ":BufferGoto 4<CR>", desc = "Go to buffer 4" },
		{ "<leader>b5", ":BufferGoto 5<CR>", desc = "Go to buffer 5" },
		{ "<leader>b6", ":BufferGoto 6<CR>", desc = "Go to buffer 6" },
		{ "<leader>b7", ":BufferGoto 7<CR>", desc = "Go to buffer 7" },
		{ "<leader>b8", ":BufferGoto 8<CR>", desc = "Go to buffer 8" },
		{ "<leader>b9", ":BufferGoto 9<CR>", desc = "Go to buffer 9" },
		{ "<leader>bl", ":BufferLast<CR>", desc = "Last buffer" },
		{ "<leader>bc", ":BufferClose<CR>", desc = "Close buffer" },
		{ "<leader>br", ":BufferRestore<CR>", desc = "Restore buffer" },
	},
}
