local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.enable({
	"eslint",
	"gopls",
	"hls",
	"lua_ls",
	"nixd",
	"ocamllsp",
	"oxlint",
	"rust_analyzer",
	"ts_ls",
	"vue_ls",
	"zls",
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

return {}
