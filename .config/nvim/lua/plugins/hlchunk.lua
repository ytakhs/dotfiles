local loader = require("config.loader")

vim.pack.add({ "https://github.com/shellRaining/hlchunk.nvim" }, { load = false })
loader.on_event({ "BufReadPre", "BufNewFile" }, "hlchunk.nvim", function()
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
end)
