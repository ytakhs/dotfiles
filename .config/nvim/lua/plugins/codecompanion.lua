local loader = require("config.loader")

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	{ src = "https://github.com/olimorris/codecompanion.nvim", version = vim.version.range("^19.0") },
}, { load = false })

local function setup()
	require("codecompanion").setup({
		opts = {
			language = "Japanese",
		},
		display = {
			chat = {
				show_header_separator = true,
			},
		},
		interactions = {
			chat = {
				opts = {
					completion_provider = "blink",
				},
			},
		},
		strategies = {
			chat = {
				adapter = "copilot",
				roles = {
					llm = function(adapter)
						return "CodeCompanion(" .. adapter.formatted_name .. ")"
					end,
				},
				keymaps = {
					send = {
						modes = { n = "<CR>", i = "<Nop>" },
					},
					close = {
						modes = { n = "q", i = "<Nop>" },
					},
				},
				slash_commands = {
					["buffer"] = {
						opts = {
							provider = "snacks",
						},
					},
					["file"] = {
						opts = {
							provider = "snacks",
						},
					},
					["help"] = {
						opts = {
							provider = "snacks",
						},
					},
					["symbols"] = {
						opts = {
							provider = "snacks",
						},
					},
					["workspace"] = {
						opts = {
							provider = "snacks",
						},
					},
				},
			},
			inline = {
				adapter = "copilot",
			},
		},
		adapters = {
			copilot = function()
				return require("codecompanion.adapters").extend("copilot", {
					schema = {
						model = {
							default = "auto",
						},
					},
				})
			end,
		},
		prompt_library = {},
	})
end

loader.on_cmd(
	{ "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
	{ "plenary.nvim", "nvim-treesitter", "codecompanion.nvim" },
	setup
)

vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanion<cr>", { desc = "Code Companion" })
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "Code Companion Actions" })
vim.keymap.set({ "n", "v" }, "<leader>ch", "<cmd>CodeCompanionChat<cr>", { desc = "Code Companion Chat" })
