vim.pack.add({
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1.10.2") },
}, { load = false })

vim.cmd.packadd("friendly-snippets")
vim.cmd.packadd("blink.cmp")

require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	keymap = {
		preset = "enter",
	},
})
