local loader = require("config.loader")

vim.pack.add({
	"https://github.com/copilotlsp-nvim/copilot-lsp",
	"https://github.com/zbirenbaum/copilot.lua",
}, { load = false })

vim.g.copilot_nes_debounse = 500

local function setup()
	require("copilot").setup({
		suggestion = {
			enabled = true,
			auto_trigger = true,
		},
		filetypes = {
			markdown = false,
			org = false,
			text = false,
		},
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "BlinkCmpMenuOpen",
		callback = function()
			vim.b.copilot_suggestion_hidden = true
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "BlinkCmpMenuClose",
		callback = function()
			vim.b.copilot_suggestion_hidden = false
		end,
	})
end

loader.on_event("InsertEnter", { "copilot-lsp", "copilot.lua" }, setup)
loader.on_cmd({ "Copilot" }, { "copilot-lsp", "copilot.lua" }, setup)
