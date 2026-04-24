vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.splitright = true
vim.o.exrc = true

vim.api.nvim_create_user_command("PackUpdate", function(ctx)
	local names = #ctx.fargs > 0 and ctx.fargs or nil
	vim.pack.update(names)
end, { nargs = "*", desc = "Update plugins via vim.pack" })
