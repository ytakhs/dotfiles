local loader = require("config.loader")

vim.pack.add({ "https://github.com/nvim-mini/mini.splitjoin" }, { load = false })
loader.on_event({ "BufReadPre", "BufNewFile" }, "mini.splitjoin", function()
	require("mini.splitjoin").setup({})
end)
