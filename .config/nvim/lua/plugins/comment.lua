vim.pack.add({ "https://github.com/numToStr/Comment.nvim" }, { load = false })
vim.cmd.packadd("Comment.nvim")
require("Comment").setup({})
