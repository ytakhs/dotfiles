local loader = require("config.loader")

vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { load = false })
loader.on_event("BufReadPre", "conform.nvim", function()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			nix = { "nixfmt" },
			typescript = { "oxfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	})
end)

vim.keymap.set("n", "<leader>F", function()
	require("conform").format({ async = true })
end, { desc = "Format file with Conform" })
