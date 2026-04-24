local loader = require("config.loader")

vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { load = false })
loader.on_event("UIEnter", "which-key.nvim", function()
	require("which-key").setup({})
end)

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
