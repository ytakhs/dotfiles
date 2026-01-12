return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	version = "*",
	config = function()
		require("toggleterm").setup({})
		vim.keymap.set("n", "<leader>t", ":ToggleTerm direction=float<CR>", { desc = "Toggle Terminal" })
	end,
}
