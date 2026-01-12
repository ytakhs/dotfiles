return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
				},
				hidden_by_name = {
					"node_modules",
					".git",
				},
				never_show = {
					".DS_Store",
				},
			},
		})

		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
		vim.keymap.set("n", "<leader>0", ":Neotree focus<CR>")
	end,
}
