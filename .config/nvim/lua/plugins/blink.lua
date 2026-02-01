return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		keymap = {
			preset = "enter",
		},
	},
}
