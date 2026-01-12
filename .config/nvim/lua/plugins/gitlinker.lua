return {
	"linrongbin16/gitlinker.nvim",
	cmd = "GitLink",
	opts = {},
	config = function()
		require("gitlinker").setup()

		vim.keymap.set("v", "<leader>gy", ":GitLink<CR>", { desc = "Yank Git link" })
		vim.keymap.set("v", "<leader>gY", ":GitLink!<CR>", { desc = "Open Git link" })
	end,
}
