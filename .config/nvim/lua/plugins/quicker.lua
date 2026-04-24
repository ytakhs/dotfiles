local loader = require("config.loader")

vim.pack.add({ "https://github.com/stevearc/quicker.nvim" }, { load = false })
loader.on_ft("qf", "quicker.nvim", function()
	require("quicker").setup({})
end)
