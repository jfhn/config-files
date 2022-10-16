local font_zoom_factor = 1.2;
local gui_font_family  = nil;
local gui_fontsize     = 0;

ui_set_font = function(font_family, fontsize)
	gui_font_family = font_family;
	gui_fontsize    = fontsize;
	vim.opt.guifont = {gui_font_family, string.format("h%d", gui_fontsize)};
	print(string.format("family: %s, size: %d", gui_font_family, gui_fontsize));
end

-- TODO: Make this work.
-- This should be replaced by the native scale feature.
ui_increase_fontsize = function()
	gui_fontsize = math.ceil(gui_fontsize * font_zoom_factor);
	ui_set_font(gui_font_family, gui_fontsize);
end

ui_decrease_fontsize = function()
	gui_fontsize = math.ceil(gui_fontsize / font_zoom_factor);
	ui_set_font(gui_font_family, gui_fontsize);
end

print("module loaded: ui.font");
