-- Personal notes search in ~/docs
local docs_path = vim.fn.expand("~/docs")

vim.api.nvim_create_user_command("DocsFind", function()
  require("telescope.builtin").find_files({
    cwd = docs_path,
    find_command = { "rg", "--files", "--sort", "path" },
  })
end, { desc = "Find notes in ~/docs" })

vim.api.nvim_create_user_command("DocsGrep", function()
  require("telescope.builtin").live_grep({ cwd = docs_path })
end, { desc = "Grep notes in ~/docs" })

local function scan_dirs_recursive(base, prefix)
  local dirs = {}
  local handle = vim.loop.fs_scandir(base)
  if handle then
    while true do
      local name, ftype = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if ftype == "directory" then
        local rel_path = prefix ~= "" and (prefix .. "/" .. name) or name
        table.insert(dirs, rel_path)
        local sub_dirs = scan_dirs_recursive(base .. "/" .. name, rel_path)
        for _, sub in ipairs(sub_dirs) do
          table.insert(dirs, sub)
        end
      end
    end
  end
  return dirs
end

local function get_docs_dir_items()
  local items = { { text = "(root)", dir = "" } }
  local dirs = scan_dirs_recursive(docs_path, "")
  table.sort(dirs)
  for _, dir in ipairs(dirs) do
    table.insert(items, { text = dir, dir = dir })
  end
  table.insert(items, { text = "+ New directory", new = true })
  return items
end

local function create_note(dir)
  vim.ui.input({ prompt = "Note name: " }, function(name)
    if name and name ~= "" then
      local filename = name:match("%.md$") and name or (name .. ".md")
      local filepath = docs_path .. "/" .. (dir ~= "" and (dir .. "/") or "") .. filename
      local parent = vim.fn.fnamemodify(filepath, ":h")
      vim.fn.mkdir(parent, "p")
      vim.cmd("edit " .. filepath)
    end
  end)
end

vim.api.nvim_create_user_command("DocsNew", function()
  local items = get_docs_dir_items()

  Snacks.picker.pick({
    source = "select",
    items = items,
    format = "text",
    confirm = function(picker, item)
      picker:close()
      if item.new then
        vim.ui.input({ prompt = "New directory name: " }, function(dirname)
          if dirname and dirname ~= "" then
            create_note(dirname)
          end
        end)
      else
        create_note(item.dir)
      end
    end
  })
end, { desc = "Create new note in ~/docs" })

local function get_docs_file_items()
  local items = {}
  local handle = io.popen('rg --files --sort path "' .. docs_path .. '"')
  if handle then
    for line in handle:lines() do
      local rel_path = line:sub(#docs_path + 2)
      table.insert(items, { text = rel_path, path = line })
    end
    handle:close()
  end
  return items
end

vim.api.nvim_create_user_command("DocsDelete", function()
  local items = get_docs_file_items()

  Snacks.picker.pick({
    source = "select",
    items = items,
    format = "text",
    preview = false,
    confirm = function(picker, item)
      picker:close()
      vim.ui.select({ "Yes", "No" }, { prompt = "Delete " .. item.text .. "?" }, function(choice)
        if choice == "Yes" then
          os.remove(item.path)
          vim.notify("Deleted: " .. item.text, vim.log.levels.INFO)
        end
      end)
    end
  })
end, { desc = "Delete note in ~/docs" })

vim.keymap.set("n", "<leader>zf", ":DocsFind<CR>", { desc = "Find notes in ~/docs" })
vim.keymap.set("n", "<leader>zg", ":DocsGrep<CR>", { desc = "Grep notes in ~/docs" })
vim.keymap.set("n", "<leader>zn", ":DocsNew<CR>", { desc = "New note in ~/docs" })
vim.keymap.set("n", "<leader>zx", ":DocsDelete<CR>", { desc = "Delete note in ~/docs" })
