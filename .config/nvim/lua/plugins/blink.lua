return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				org = { "orgmode" },
			},
			providers = {
				orgmode = {
					name = "Orgmode",
					module = "orgmode.org.autocompletion.blink",
					fallbacks = { "buffer" },
				},
			},
		},
		keymap = {
			preset = "enter",
		},
	},
}
