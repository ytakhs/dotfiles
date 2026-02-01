-- Example configuration for Vue.js support in Neovim LSP
vim.lsp.config.ts_ls = {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "vue-language-server",
				languages = { "vue" },
			},
		},
	},
}
