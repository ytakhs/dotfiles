return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	opts = {
		filesystem = {
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hidden_by_name = {
					"node_modules",
				},
				always_show = {
					".gitignore",
				},
				always_show_by_pattern = {
					".env*",
					".mise*.toml",
				},
				never_show = {
					".DS_Store",
					".git",
				},
			},
		},
	},
	keys = {
		{ "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Neo-tree" },
		{ "<leader>0", ":Neotree reveal<CR>", desc = "Reveal file in Neo-tree" },
	},
}
