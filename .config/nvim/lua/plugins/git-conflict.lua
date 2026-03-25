return {
	"akinsho/git-conflict.nvim",
	config = true,
	event = "VeryLazy",
	keys = {
		{ "<leader>gc", "<cmd>GitConflictListQf<CR>", desc = "List Conflicts" },
	},
}
