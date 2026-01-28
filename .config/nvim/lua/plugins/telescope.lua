return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		pickers = {
			find_files = {
				hidden = true,
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			},
		},
	},
	keys = {
		{
			"<leader>ff",
			":Telescope find_files<CR>",
			desc = "Telescope find files",
		},
		{
			"<leader>fg",
			":Telescope live_grep<CR>",
			desc = "Telescope live grep",
		},
		{
			"<leader>fb",
			":Telescope buffers<CR>",
			desc = "Telescope buffers",
		},
		{
			"<leader>fh",
			":Telescope help_tags<CR>",
			desc = "Telescope help tags",
		},
	},
}
