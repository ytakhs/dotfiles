return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		require("orgmode").setup({
			org_agenda_files = "~/orgfiles/**/*",
			org_default_notes_file = "~/orgfiles/refile.org",
			org_capture_templates = {
				t = {
					description = "TODO",
					template = "* TODO %?\n SCHEDULED: %t",
					target = "~/orgfiles/refile.org",
				},
			},
		})
	end,
}
