return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = { "VeryLazy" },
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup({})
	end,
	keys = {
		{ "<C-l>", ":BufferLineCycleNext<CR>", desc = "Next buffer" },
		{ "<C-h>", ":BufferLineCyclePrev<CR>", desc = "Previous buffer" },
		{ "<leader>b1", ":BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
		{ "<leader>b2", ":BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
		{ "<leader>b3", ":BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
		{ "<leader>b4", ":BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
		{ "<leader>b5", ":BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
		{ "<leader>b6", ":BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
		{ "<leader>b7", ":BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
		{ "<leader>b8", ":BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
		{ "<leader>b9", ":BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
		{ "<leader>bc", ":BufferLineCloseOthers<CR>", desc = "Close buffer" },
	},
}
