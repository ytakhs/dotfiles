return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		indent = {
			enable = true,
		},
		line_num = {
			enable = true,
		},
		chunk = {
			enable = true,
		},
	},
}
