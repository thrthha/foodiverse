extends Control

@export var game_scene: PackedScene

var page: VBoxContainer
var status_label: Label
var level_screen := false

const CREAM := "#FFF4E3"
const BROWN := "#A63D24"
const GREEN := "#23865B"
const TEXT_BROWN := "#62483C"

func _ready() -> void:
	show_home_page()


func clear_page() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()


func show_home_page() -> void:
	level_screen = false
	clear_page()

	var background := ColorRect.new()
	background.color = Color(CREAM)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	page = VBoxContainer.new()
	page.custom_minimum_size = Vector2(300, 0)
	page.add_theme_constant_override("separation", 18)
	center.add_child(page)

	var title := Label.new()
	title.text = "🍳 FOODIVERSE 🌎"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 34)
	title.add_theme_color_override("font_color", Color(BROWN))
	page.add_child(title)

	var subtitle := Label.new()
	subtitle.text = "MIX. DISCOVER. COLLECT!"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_color_override("font_color", Color(TEXT_BROWN))
	page.add_child(subtitle)

	var stars := Label.new()
	stars.text = "⭐ YOUR CULINARY ADVENTURE AWAITS!"
	stars.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	stars.add_theme_color_override("font_color", Color(TEXT_BROWN))
	page.add_child(stars)

	var play_button := make_button("▶  PLAY", GREEN)
	play_button.pressed.connect(start_game)
	page.add_child(play_button)

	var levels_button := make_button("🗺️  SELECT LEVEL", "#E8D8C6")
	levels_button.add_theme_color_override("font_color", Color(TEXT_BROWN))
	levels_button.pressed.connect(show_level_page)
	page.add_child(levels_button)

	var exit_button := make_button("✕  EXIT GAME", "#E8D8C6")
	exit_button.add_theme_color_override("font_color", Color(TEXT_BROWN))
	exit_button.pressed.connect(exit_game)
	page.add_child(exit_button)

	status_label = Label.new()
	status_label.text = "Ready to become a world-class chef?"
	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	status_label.add_theme_color_override("font_color", Color(BROWN))
	page.add_child(status_label)


func show_level_page() -> void:
	level_screen = true
	clear_page()

	var background := ColorRect.new()
	background.color = Color(CREAM)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 24)
	margin.add_theme_constant_override("margin_right", 24)
	margin.add_theme_constant_override("margin_top", 24)
	margin.add_theme_constant_override("margin_bottom", 24)
	add_child(margin)

	page = VBoxContainer.new()
	page.add_theme_constant_override("separation", 16)
	margin.add_child(page)

	var title := Label.new()
	title.text = "🗺️ SELECT YOUR LEVEL"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color(BROWN))
	page.add_child(title)

	var description := Label.new()
	description.text = "Earn stars by discovering new recipes!"
	description.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	description.add_theme_color_override("font_color", Color(TEXT_BROWN))
	page.add_child(description)

	var level_1 := make_button("⭐ LEVEL 1: KERALA KITCHEN", GREEN)
	level_1.pressed.connect(start_game)
	page.add_child(level_1)

	var level_2 := make_button("🔒 LEVEL 2: WORLD KITCHEN", "#E8D8C6")
	level_2.add_theme_color_override("font_color", Color(TEXT_BROWN))
	level_2.pressed.connect(show_locked_message)
	page.add_child(level_2)

	var level_3 := make_button("🔒 LEVEL 3: MASTER CHEF", "#E8D8C6")
	level_3.add_theme_color_override("font_color", Color(TEXT_BROWN))
	level_3.pressed.connect(show_locked_message)
	page.add_child(level_3)

	status_label = Label.new()
	status_label.text = "Level 1 is ready to play!"
	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	status_label.add_theme_color_override("font_color", Color(BROWN))
	page.add_child(status_label)

	var back_button := make_button("← BACK TO HOME", "#E8D8C6")
	back_button.add_theme_color_override("font_color", Color(TEXT_BROWN))
	back_button.pressed.connect(show_home_page)
	page.add_child(back_button)


func make_button(button_text: String, button_color: String) -> Button:
	var button := Button.new()
	button.text = button_text
	button.custom_minimum_size = Vector2(280, 58)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 17)

	var style := StyleBoxFlat.new()
	style.bg_color = Color(button_color)
	style.set_corner_radius_all(14)
	style.set_content_margin_all(12)
	style.border_width_bottom = 3
	style.border_color = Color(button_color).darkened(0.18)
	button.add_theme_stylebox_override("normal", style)

	var hover := style.duplicate() as StyleBoxFlat
	hover.bg_color = Color(button_color).lightened(0.08)
	button.add_theme_stylebox_override("hover", hover)

	button.add_theme_color_override("font_color", Color("#FFFFFF") if button_color == GREEN else Color(TEXT_BROWN))
	button.add_theme_color_override("font_hover_color", Color(BROWN))
	return button


func start_game() -> void:
	if game_scene == null:
		status_label.text = "Please connect your Foodiverse game scene in the Inspector."
		return

	get_tree().change_scene_to_packed(game_scene)


func show_locked_message() -> void:
	status_label.text = "🔒 Discover more recipes to unlock this level!"


func exit_game() -> void:
	get_tree().quit()
