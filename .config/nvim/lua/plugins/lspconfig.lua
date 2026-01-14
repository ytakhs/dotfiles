return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"folke/neoconf.nvim", -- for lspconfig integration
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			ts_server = {},
			gopls = {},
			zls = {},
			vue_ls = {
				filetypes = { "vue" },
			},
		}

		vim.lsp.enable({
			"lua_ls",
			"ts_server",
			"gopls",
			"zls",
			"vue_ls",
		})

		for server, config in pairs(servers) do
			config.capabilities = capabilities
			vim.lsp.config[server] = config
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local opts = { buffer = args.buf }

				vim.keymap.set(
					"n",
					"gd",
					vim.lsp.buf.definition,
					vim.tbl_extend("force", opts, { desc = "Go to Definition" })
				)
				vim.keymap.set(
					"n",
					"gr",
					vim.lsp.buf.references,
					vim.tbl_extend("force", opts, { desc = "References" })
				)
				vim.keymap.set(
					"n",
					"K",
					vim.lsp.buf.hover,
					vim.tbl_extend("force", opts, { desc = "Hover Documentation" })
				)
			end,
		})

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})
	end,
}
