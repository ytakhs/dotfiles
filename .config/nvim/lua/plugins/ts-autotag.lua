local loader = require("config.loader")

vim.pack.add({ "https://github.com/windwp/nvim-ts-autotag" }, { load = false })
loader.on_event({ "BufReadPre", "BufNewFile" }, "nvim-ts-autotag", function()
	require("nvim-ts-autotag").setup({})
end)
