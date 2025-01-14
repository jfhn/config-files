require("oil").setup {
	default_file_explorer = true,

	win_options = {
		signcolumn = "no",
		cursorcolumn = false,
		spell = false,
	},

	delete_to_trash = true,
	skip_confirm_for_simple_edits = false,
	prompt_save_on_select_new_entry = true,

	lsp_file_methods = {
		enabled = false,
		autosave_changes = false,
	},

	watch_for_changes = true,
	use_default_keymaps = true,

	view_options = {
		show_hidden = true
	},
}
