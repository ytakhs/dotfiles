local M = {}

local function packadd_and_setup(names, setup_fn)
	if type(names) == "string" then
		names = { names }
	end
	for _, name in ipairs(names) do
		vim.cmd.packadd(name)
	end
	if setup_fn then
		setup_fn()
	end
end

function M.on_event(events, name, setup_fn, pattern)
	vim.api.nvim_create_autocmd(events, {
		pattern = pattern or "*",
		once = true,
		callback = function()
			packadd_and_setup(name, setup_fn)
		end,
	})
end

function M.on_cmd(cmds, names, setup_fn)
	for _, cmd in ipairs(cmds) do
		vim.api.nvim_create_user_command(cmd, function(ctx)
			vim.api.nvim_del_user_command(cmd)
			packadd_and_setup(names, setup_fn)
			vim.cmd({
				cmd = cmd,
				args = { ctx.args },
				bang = ctx.bang,
				range = { ctx.line1, ctx.line2 },
			})
		end, { nargs = "*", range = true, bang = true })
	end
end

function M.on_ft(filetypes, name, setup_fn)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetypes,
		once = true,
		callback = function()
			packadd_and_setup(name, setup_fn)
		end,
	})
end

return M
