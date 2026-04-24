vim.pack.add({ "https://github.com/folke/snacks.nvim" }, { load = false })
vim.cmd.packadd("snacks.nvim")

require("snacks").setup({
	explorer = {
		replace_netrw = true,
		trash = true,
	},
	picker = {
		sources = {
			explorer = {
				hidden = true,
				ignored = true,
				diagnostics = true,
				diagnostics_open = true,
				git_status = true,
				git_status_open = true,
				exclude = {
					".git",
					".DS_Store",
				},
			},
			files = {
				hidden = true,
				ignored = false,
				exclude = {
					".git",
					".DS_Store",
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "Toggle Explorer" })

vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })

vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files({ hidden = true })
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent" })

vim.keymap.set("n", "<leader>fo", function()
	require("aerial").snacks_picker()
end, { desc = "Outline" })

vim.keymap.set("n", "<leader>sg", function()
	Snacks.picker.grep({ hidden = true })
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>sh", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })

vim.keymap.set("n", "<leader>sq", function()
	Snacks.picker.qflist()
end, { desc = "Quickfix List" })

vim.keymap.set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

vim.keymap.set("n", "<leader>S", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

vim.keymap.set("n", "<leader>gb", function()
	Snacks.picker.git_branches()
end, { desc = "Git Branches" })

vim.keymap.set("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { desc = "Git Log" })

vim.keymap.set("n", "<leader>gp", function()
	Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (open)" })

vim.keymap.set("n", "<leader>gP", function()
	Snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub Pull Requests (all)" })

vim.keymap.set({ "n", "v" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse" })
