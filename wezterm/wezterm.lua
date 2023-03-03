local wt = require("wezterm");

return {
	-- Appearance
	-- weight="Bold",
	-- font = wt.font("Iosevka Term SS02"),
	font = wt.font("Liberation Mono"),
	font_size = 11,
	color_scheme = "Gruvbox Dark",
	window_background_opacity = 0.9,

	default_prog = {"powershell.exe", "-NoLogo"},

	-- Keybindings
	keys = {
		{key = "l", mods = "ALT", action="ShowLauncher"},
		{
			key = "w", mods = "CTRL|ALT",
			action = wt.action {CloseCurrentTab = {confirm = true}}
		},
		{
			key = "-", mods = "CTRL|ALT",
			action = wt.action.SplitVertical {domain = "CurrentPaneDomain"} -- {SplitVertical = {args={"cmd"}}}
		},
		{
			key = "=", mods = "CTRL|ALT",
			action = wt.action.SplitHorizontal {domain = "CurrentPaneDomain"}
			-- action = wt.action {SplitHorizontal = {args={"cmd"}}}
		},
		{
			key = "0", mods = "CTRL|ALT",
			action = wt.action {CloseCurrentPane = {confirm = true}}
		},
		{
			key = "LeftArrow", mods="CTRL|ALT",
			action = wt.action {ActivatePaneDirection = "Left"}
		},
		{
			key = "RightArrow", mods="CTRL|ALT",
			action = wt.action {ActivatePaneDirection = "Right"}
		},
		{
			key = "UpArrow", mods="CTRL|ALT",
			action = wt.action {ActivatePaneDirection = "Up"}
		},
		{
			key = "DownArrow", mods="CTRL|ALT",
			action = wt.action {ActivatePaneDirection = "Down"}
		},
		{
			key = "UpArrow", mods = "CTRL|SHIFT",
			action = wt.action.ScrollByLine(-1)
		},
		{
			key = "DownArrow", mods = "CTRL|SHIFT",
			action = wt.action.ScrollByLine(1)
		},
		{
			key = "Enter", mods = "CTRL|ALT",
			action = wt.action.TogglePaneZoomState
		}
	},

	-- Other
	scrollback_lines = 3500,

	-- Startup
	default_cwd = "C:\\Users\\JanHi\\dev",
	launch_menu = {
		{
			label = "powershell",
			args  = {"powershell"},
			-- cwd   = "C:\\Users\\JanHi\\dev",
		},
		{
			label = "WSL Bash",
			args  = {"bash"}
		}
	},
}
