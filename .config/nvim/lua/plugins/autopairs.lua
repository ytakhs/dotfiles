local loader = require("config.loader")

vim.pack.add({ "https://github.com/windwp/nvim-autopairs" }, { load = false })
loader.on_event("InsertEnter", "nvim-autopairs", function()
	require("nvim-autopairs").setup({})
end)
