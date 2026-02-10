return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-frecency.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"stevearc/aerial.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--glob",
						"!**/.git/*",
					},
				},
				live_grep = {
					additional_args = {
						"--hidden",
						"--glob",
						"!**/.git/*",
					},
				},
			},
		})

		telescope.load_extension("frecency")
		telescope.load_extension("file_browser")
		telescope.load_extension("aerial")
	end,
	keys = {
		{
			"<leader>fb",
			":Telescope file_browser<CR>",
			desc = "Telescope file browser",
		},
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
			"<leader>ft",
			":Telescope buffers<CR>",
			desc = "Telescope buffers",
		},
		{
			"<leader>fh",
			":Telescope help_tags<CR>",
			desc = "Telescope help tags",
		},
		{
			"<leader>fr",
			":Telescope frecency workspace=CWD<CR>",
			desc = "Telescope frecency",
		},
		{
			"<leader>fo",
			":Telescope aerial<CR>",
			desc = "Telescope symbols with aerial",
		},
	},
}
