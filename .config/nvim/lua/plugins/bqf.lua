local loader = require("config.loader")

vim.pack.add({ "https://github.com/kevinhwang91/nvim-bqf" }, { load = false })
loader.on_ft("qf", "nvim-bqf", function()
	require("bqf").setup({})
end)
