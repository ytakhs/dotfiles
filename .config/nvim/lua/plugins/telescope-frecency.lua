return {
	"nvim-telescope/telescope-frecency.nvim",
	version = "*",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("telescope").load_extension("frecency")
	end,
	keys = {
		{
			"<leader>fr",
			":Telescope frecency workspace=CWD<CR>",
			desc = "Telescope frecency",
		},
	},
}
