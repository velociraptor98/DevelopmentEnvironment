local gpu_adapters = require("utils.gpu-adapter")
local colors = require("colors.custom")

return {
	max_fps = 120,
	front_end = "WebGpu", ---@type 'WebGpu' | 'OpenGL' | 'Software'
	webgpu_power_preference = "HighPerformance",
	webgpu_preferred_adapter = gpu_adapters:pick_best(),
	underline_thickness = "1.5pt",

	animation_fps = 120,
	cursor_blink_ease_in = "EaseOut",
	cursor_blink_ease_out = "EaseOut",
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 650,

	colors = colors,

	enable_scroll_bar = false,

	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = true,
	tab_max_width = 30,
	show_tab_index_in_tab_bar = true,
	switch_to_last_active_tab_when_closing_tab = true,

	command_palette_fg_color = "#282828",
	command_palette_bg_color = "#282828",
	command_palette_font_size = 12,
	command_palette_rows = 25,

	window_padding = {
		left = 8,
		right = 0,
		top = 8,
		bottom = 0,
	},
	adjust_window_size_when_changing_font_size = false,
	window_close_confirmation = "NeverPrompt",
	window_frame = {
		active_titlebar_bg = "#0c0b0f",
	},
	inactive_pane_hsb = {
		saturation = 1,
		brightness = 1,
	},

	visual_bell = {
		fade_in_function = "EaseIn",
		fade_in_duration_ms = 250,
		fade_out_function = "EaseOut",
		fade_out_duration_ms = 250,
		target = "CursorColor",
	},
	window_decorations = "NONE | RESIZE",
	window_background_opacity = 0.9,
	macos_window_background_blur = 20,
	-- win32_system_backdrop = 'Acrylic',
	-- default_prog = {"powershell/exe", "-NoLogo"},
}
