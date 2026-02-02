-- Example configuration for Vue.js support in Neovim LSP
vim.lsp.config.ts_ls = {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.fs.joinpath(vim.fn.getcwd(), "node_modules", "@vue", "language-server"),
				languages = { "vue" },
			},
		},
	},
}
