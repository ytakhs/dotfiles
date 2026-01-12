return {
	"stevearc/conform.nvim",
	event = { "BufReadPre" },
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format file with Conform",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofumpt", "goimports" },
			typescript = { "oxfmt" },
			rust = { "rustfmt" },
			zig = { "zigfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
