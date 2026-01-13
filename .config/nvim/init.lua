vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2 -- always show tabline
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.lazy")
require("config.docs")
