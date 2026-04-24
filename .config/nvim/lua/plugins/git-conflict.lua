local loader = require("config.loader")

vim.pack.add({ "https://github.com/akinsho/git-conflict.nvim" }, { load = false })
loader.on_event("UIEnter", "git-conflict.nvim", function()
	require("git-conflict").setup()
end)

vim.keymap.set("n", "<leader>gc", "<cmd>GitConflictListQf<CR>", { desc = "List Conflicts" })
