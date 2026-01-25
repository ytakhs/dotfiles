return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local servers = {
			gopls = {},
			hls = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},
			nixd = {},
			ocamllsp = {},
			rust_analyzer = {},
			ts_ls = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
				init_options = {
					plugins = vim.g.vue_language_server_path and {
						{
							name = "@vue/typescript-plugin",
							languages = { "vue" },
							location = vim.g.vue_language_server_path,
						},
					} or {},
				},
			},
			vue_ls = {},
			zls = {},
		}

		vim.lsp.enable({
			"gopls",
			"hls",
			"lua_ls",
			"nixd",
			"ocamllsp",
			"rust_analyzer",
			"ts_ls",
			"vue_ls",
			"zls",
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
					"gi",
					vim.lsp.buf.implementation,
					vim.tbl_extend("force", opts, { desc = "Implementation" })
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
