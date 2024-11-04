local wt = require("wezterm");

return {
	-- Appearance
	font = wt.font("Iosevka Fixed"),
	font_size = 16,
	-- font = wt.font("Source Code Pro"),
	-- font = wt.font({family = "Fira Mono"}),
	-- font = wt.font("Ubuntu Mono Ligaturized"),
	-- font = wt.font("Consolas ligaturized v2"),
	-- font = wt.font("Cascadia Code"),
	-- font = wt.font("Consolas ligaturized v2"),
	-- font = wt.font("Liberation Mono"),
	-- font = wt.font("Hasklig"),
	-- color_scheme = "Gruvbox Dark",
	-- color_scheme = "vimbones",
	-- color_scheme = "Gruber (base16)",
	-- color_scheme = "Unsifted Wheat (terminal.sexy)",
	color_scheme = "Solarized (light) (terminal.sexy)",
	-- color_scheme = "rose-pine",
	-- window_background_opacity = 0.9,
	window_padding = {
		left = 1,
		right = 1,
		top = 1,
		bottom = 1,
	},

	default_prog = {"powershell.exe", "-NoLogo"},

	-- Keybindings
	keys = {
		{key = "l", mods = "ALT", action="ShowLauncher"},
		{
			key = "w", mods = "CTRL|SHIFT",
			action = wt.action.CloseCurrentPane {confirm = true}
		},
		{
			key = "w", mods = "CTRL|ALT",
			action = wt.action.CloseCurrentPane {confirm = true}
		},
		-- {
		-- 	key = "w", mods = "CTRL",
		-- 	action = wt.action.SendKey {key = "Backspace", mods = "CTRL"}
		-- },
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
