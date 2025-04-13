local wt = require("wezterm");
local ok, local_config = pcall(require, "local");
if not ok then
	---@param config table<string, any>
	---@param defaults table<string, table>
	---@nodiscard
	---@return table<string, any> config, table<string, table> custom
	local_config = function(config, defaults)
		return config, defaults;
	end
end

local defaults = {
	fonts = {
		{family = "Iosevka Fixed", size = 16},
		{family = "Rec Mono Casual", size = 14},
		{family = "JetBrains Mono", size = 14},
		{family = "DejaVu Sans Mono", size = 14},
		{family = "Ubuntu Mono", size = 16},
		{family = "Fira Mono", size = 14},
	},

	themes = {
		"Gruber (base16)",
		"rose-pine",
		"Solarized (light) (terminal.sexy)",
		"Material (base16)",
	}
}

local default_config = {
	-- Appearance
	harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'},
	color_scheme = defaults.themes[1],
	font = wt.font(defaults.fonts[1].family),
	font_size = defaults.fonts[1].size,
	window_padding = {left = 1, right = 1, top = 1, bottom = 1},
	adjust_window_size_when_changing_font_size = false,

	-- font_rules = {
	-- 	{
	-- 		intensity = "Normal",
	-- 		italic = true,
	-- 		font = wt.font {family = font_data.family, weight = "Regular", style = "Italic"},
	-- 	},
	-- 	{
	-- 		intensity = "Normal",
	-- 		font = wt.font {family = font_data.family, weight = "Regular"},
	-- 	},
	-- 	{
	-- 		intensity = "Bold",
	-- 		font = wt.font {family = font_data.family, weight = "Bold"},
	-- 	},
	-- },

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
			key = "\\", mods = "CTRL|ALT",
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
}

local config, custom = local_config(default_config, defaults);

wt.on("augment-command-palette", function()
	local font_choices = {}
	for index, data in ipairs(custom.fonts) do
		font_choices[#font_choices + 1] = {label = data.family, id = tostring(index)}
	end

	local theme_choices = {}
	for index, theme in ipairs(custom.themes) do
		theme_choices[#theme_choices + 1] = {label = theme, id = tostring(index)}
	end

	return {
		{
			brief = "Change Font",
			action = wt.action.InputSelector {
				choices = font_choices,
				action = wt.action_callback(function(window, _, id)
					local overrides = window:get_config_overrides() or {}
					local index = tonumber(id)
					local data = custom.fonts[index]
					overrides.font = wt.font(data.family)
					overrides.font_size = data.size
					window:set_config_overrides(overrides)
				end)
			}
		},
		{
			brief = "Select Font by Name",
			action = wt.action.PromptInputLine {
				description = "Enter font name",
				action = wt.action_callback(function(window, _, line)
  					local overrides = window:get_config_overrides() or {}
					overrides.font = wt.font(line)
					window:set_config_overrides(overrides)
				end)
			}
		},
		{
			brief = "Change Theme",
			action = wt.action.InputSelector {
				choices = theme_choices,
				action = wt.action_callback(function(window, _, id)
					local overrides = window:get_config_overrides() or {}
					local index = tonumber(id)
					local theme = custom.themes[index]
					overrides.color_scheme = theme
					window:set_config_overrides(overrides)
				end)
			}
		},
	}
end)

return config;
