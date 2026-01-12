return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			indent = {
				enable = true,
			},
			line_num = {
				enable = true,
			},
			chunk = {
				enable = true,
			},
		})
	end,
}
