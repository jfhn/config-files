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

---@alias FontIntensity "Half"|"Normal"|"Bold"
---@alias FontWeight "Thin"|"Light"|"Medium"|"Bold"|"Black"
---@alias FontData { family: string, size: integer, weigth: FontWeight|nil, bold: FontWeight|nil, bold_italic: FontWeight|nil }
---@alias FontRule { family: string, intensity: FontIntensity, font: table }
---@alias WeztermFont { family: string, size: integer, rules: FontRule[] }

---@param fonts WeztermFont[]
---@param font_data FontData
function add_font(fonts, font_data)
	local rules = {};
	if font_data.weigth then
		table.insert(rules, {
			intensity = "Normal",
			font = wt.font { family = font_data.family, weight = font_data.weigth }
		})
	end
	if font_data.bold then
		table.insert(rules, {
			intensity = "Bold",
			font = wt.font { family = font_data.family, weight = font_data.bold }
		})
	end
	if font_data.bold_italic then
		table.insert(rules, {
			intensity = "Bold",
			italic = true,
			font = wt.font { family = font_data.family, weight = font_data.bold }
		})
	end
	table.insert(fonts, {
		family = font_data.family,
		size = font_data.size,
		rules = rules,
	})
end

local defaults = {
	fonts = {},

	themes = {
		"Gruber (base16)",
		"Rosé Pine (Gogh)",
		"Rosé Pine Dawn (Gogh)",
		"Solarized (light) (terminal.sexy)",
		"Material (base16)",
	}
}

add_font(defaults.fonts, { family = "Iosevka Fixed", size = 16 })
-- add_font(defaults.fonts, { family = "Iosevka Fixed", size = 16, bold = "Black", bold_italic = "Black" })
-- add_font(defaults.fonts, { family = "Iosevka Fixed", size = 16, bold = "Bold", bold_italic = "Bold" })
add_font(defaults.fonts, { family = "Rec Mono Casual", size = 14 })
add_font(defaults.fonts, { family = "JetBrains Mono", size = 14, bold = "Black", bold_italic = "Black" })
add_font(defaults.fonts, { family = "DejaVu Sans Mono", size = 14 })
add_font(defaults.fonts, { family = "Ubuntu Mono", size = 16 })
add_font(defaults.fonts, { family = "Fira Mono", size = 14, bold = "Black", bold_italic = "Black" })
add_font(defaults.fonts, { family = "Source Code Pro", size = 14, bold = "Bold", bold_italic = "Bold" })
-- add_font(defaults.fonts, { family = "Fira Mono", size = 14, bold = "Bold", bold_italic = "Bold" })

local default_config = {
	-- Appearance
	harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'},
	color_scheme = defaults.themes[1],
	font = wt.font(defaults.fonts[1].family),
	font_size = defaults.fonts[1].size,
	font_rules = defaults.fonts[1].rules,
	window_padding = {left = 1, right = 1, top = 1, bottom = 1},
	adjust_window_size_when_changing_font_size = false,

	-- font_rules = {
	-- 	{
	-- 		intensity = "Normal",
	-- 		italic = true,
	-- 		font = wt.font {family = "Iosevka Fixed", weight = "Regular", style = "Italic"},
	-- 	},
	-- 	{
	-- 		intensity = "Normal",
	-- 		font = wt.font {family = "Iosevka Fixed", weight = "Regular"},
	-- 	},
	-- 	{
	-- 		intensity = "Bold",
	-- 		font = wt.font {family = "Iosevka Fixed", weight = "Bold"},
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
					overrides.font_rules = data.rules
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
