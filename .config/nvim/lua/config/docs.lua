-- Personal notes search in ~/docs
local docs_path = vim.fn.expand("~/docs")

vim.api.nvim_create_user_command("DocsFind", function()
  require("telescope.builtin").find_files({ cwd = docs_path })
end, { desc = "Find notes in ~/docs" })

vim.api.nvim_create_user_command("DocsGrep", function()
  require("telescope.builtin").live_grep({ cwd = docs_path })
end, { desc = "Grep notes in ~/docs" })

vim.api.nvim_create_user_command("DocsNew", function()
  vim.ui.input({ prompt = "Note name: " }, function(name)
    if name and name ~= "" then
      local filename = name:match("%.md$") and name or (name .. ".md")
      local filepath = docs_path .. "/" .. filename
      local dir = vim.fn.fnamemodify(filepath, ":h")
      vim.fn.mkdir(dir, "p")
      vim.cmd("edit " .. filepath)
    end
  end)
end, { desc = "Create new note in ~/docs" })

vim.keymap.set("n", "<leader>zf", ":DocsFind<CR>", { desc = "Find notes in ~/docs" })
vim.keymap.set("n", "<leader>zg", ":DocsGrep<CR>", { desc = "Grep notes in ~/docs" })
vim.keymap.set("n", "<leader>zn", ":DocsNew<CR>", { desc = "New note in ~/docs" })
