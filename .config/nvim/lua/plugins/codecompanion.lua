return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
	opts = {
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
	},
	keys = {
		{ "<leader>cc", "<cmd>CodeCompanion<cr>", desc = "Code Companion", mode = { "n", "v" } },
		{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "n", "v" } },
		{ "<leader>ch", "<cmd>CodeCompanionChat<cr>", desc = "Code Companion Chat", mode = { "n", "v" } },
	},
}
