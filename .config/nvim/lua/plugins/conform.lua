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
			nix = { "nixfmt" },
			typescript = { "oxfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
