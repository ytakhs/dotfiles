return {
	"linrongbin16/gitlinker.nvim",
	cmd = "GitLink",
	opts = {},
	keys = {
		{ "<leader>gy", ":GitLink<CR>", mode = "v", desc = "Yank Git link" },
		{ "<leader>gY", ":GitLink!<CR>", mode = "v", desc = "Open Git link" },
	},
}
