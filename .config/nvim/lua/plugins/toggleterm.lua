local loader = require("config.loader")

vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" }, { load = false })
loader.on_event("UIEnter", "toggleterm.nvim", function()
	require("toggleterm").setup({})
end)

vim.keymap.set("n", "<leader>t", ":ToggleTerm direction=float<CR>", { desc = "Toggle Terminal" })
