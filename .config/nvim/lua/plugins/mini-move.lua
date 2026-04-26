local loader = require("config.loader")

vim.pack.add({ "https://github.com/nvim-mini/mini.move" }, { load = false })
loader.on_event({ "BufReadPre", "BufNewFile" }, "mini.move", function()
	require("mini.move").setup({})
end)
