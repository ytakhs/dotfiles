local loader = require("config.loader")

vim.pack.add({ "https://github.com/ixru/nvim-markdown" }, { load = false })
loader.on_ft("markdown", "nvim-markdown")
