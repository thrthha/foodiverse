extends Node2D

var score := 0
var discoveries: Array[String] = []
var selected: Array[String] = []

var recipes := {
	"Appam|Cheese": "Cheesy Appam",
	"Fish Curry|Pasta": "Kerala Fish Curry Pasta",
	"Chocolate|Mango": "Mango Chocolate Fusion",
	"Appam|Mango": "Sweet Mango Appam",
	"Cheese|Pasta": "Cheesy Pasta",
	"Chocolate|Pasta": "Chocolate Pasta Surprise"
}

var score_label: Label
var recipe_label: Label
var selection_label: Label
var message_label: Label
var food_buttons: Array[Button] = []

func _ready() -> void:
	build_game()
func build_game() -> void:
	# Warm cream background
	var background := ColorRect.new()
	background.color = Color("#FFF4E3")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	# Page margins
	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 28)
	margin.add_theme_constant_override("margin_right", 28)
	margin.add_theme_constant_override("margin_top", 22)
	margin.add_theme_constant_override("margin_bottom", 22)
	add_child(margin)

	var ui := VBoxContainer.new()
	ui.add_theme_constant_override("separation", 12)
	margin.add_child(ui)

	# Game title
	var heading := Label.new()
	heading.text = "🍳 FOODIVERSE 🌎"
	heading.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	heading.add_theme_font_size_override("font_size", 34)
	heading.add_theme_color_override("font_color", Color("#A63D24"))
	ui.add_child(heading)

	var subtitle := Label.new()
	subtitle.text = "KERALA × WORLD  •  MIX. DISCOVER. COLLECT!"
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", 14)
	subtitle.add_theme_color_override("font_color", Color("#77594B"))
	ui.add_child(subtitle)

	# Score and discoveries
	score_label = Label.new()
	score_label.text = "⭐  SCORE: 0"
	score_label.add_theme_font_size_override("font_size", 21)
	score_label.add_theme_color_override("font_color", Color("#A63D24"))
	ui.add_child(score_label)

	recipe_label = Label.new()
	recipe_label.text = "📖  RECIPES DISCOVERED: 0 / 6"
	recipe_label.add_theme_color_override("font_color", Color("#62483C"))
	ui.add_child(recipe_label)

	# Ingredient cards
	var grid := GridContainer.new()
	grid.columns = 2
	grid.add_theme_constant_override("h_separation", 12)
	grid.add_theme_constant_override("v_separation", 12)
	ui.add_child(grid)

	var foods := [
		{"name": "Appam", "emoji": "🥞", "color": "#F4C77A"},
		{"name": "Fish Curry", "emoji": "🐟", "color": "#F29B78"},
		{"name": "Pasta", "emoji": "🍝", "color": "#F5D58A"},
		{"name": "Cheese", "emoji": "🧀", "color": "#F1D76B"},
		{"name": "Mango", "emoji": "🥭", "color": "#F7B84B"},
		{"name": "Chocolate", "emoji": "🍫", "color": "#C99A85"}
	]

	for item in foods:
		var food: String = item["name"]
		var button := Button.new()
		button.text = item["emoji"] + "  " + food
		button.custom_minimum_size = Vector2(160, 62)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.add_theme_font_size_override("font_size", 17)
		_style_food_button(button, Color(item["color"]))
		button.pressed.connect(_on_food_pressed.bind(food, button))
		grid.add_child(button)
		food_buttons.append(button)

	# Selected ingredients
	selection_label = Label.new()
	selection_label.text = "🧺  Your ingredients: None + None"
	selection_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	selection_label.add_theme_font_size_override("font_size", 16)
	selection_label.add_theme_color_override("font_color", Color("#62483C"))
	ui.add_child(selection_label)

	# Mix button
	var mix_button := Button.new()
	mix_button.text = "✨  MIX & DISCOVER!  ✨"
	mix_button.custom_minimum_size = Vector2(200, 64)
	mix_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	mix_button.add_theme_font_size_override("font_size", 21)
	_style_food_button(mix_button, Color("#23865B"))
	mix_button.add_theme_color_override("font_color", Color.WHITE)
	mix_button.add_theme_color_override("font_hover_color", Color("#FFF2B3"))
	mix_button.pressed.connect(_on_mix_pressed)
	ui.add_child(mix_button)

	# Clear button
	var clear_button := Button.new()
	clear_button.text = "↻  Clear selections"
	clear_button.custom_minimum_size = Vector2(160, 42)
	clear_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_style_food_button(clear_button, Color("#E8D8C6"), Color("#62483C"))
	clear_button.pressed.connect(_on_clear_pressed)
	ui.add_child(clear_button)

	# Discovery message
	message_label = Label.new()
	message_label.text = "👩‍🍳 Welcome, chef! Discover all 6 fusion recipes."
	message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	message_label.add_theme_font_size_override("font_size", 16)
	message_label.add_theme_color_override("font_color", Color("#A63D24"))
	ui.add_child(message_label)


func _style_food_button(
	button: Button,
	bg_color: Color,
	text_color: Color = Color("#51392D")
) -> void:
	var normal := StyleBoxFlat.new()
	normal.bg_color = bg_color
	normal.set_corner_radius_all(14)
	normal.set_content_margin_all(10)
	normal.border_width_bottom = 3
	normal.border_color = bg_color.darkened(0.18)
	button.add_theme_stylebox_override("normal", normal)

	var hover := normal.duplicate() as StyleBoxFlat
	hover.bg_color = bg_color.lightened(0.10)
	button.add_theme_stylebox_override("hover", hover)

	var pressed := normal.duplicate() as StyleBoxFlat
	pressed.bg_color = bg_color.darkened(0.12)
	button.add_theme_stylebox_override("pressed", pressed)

	button.add_theme_color_override("font_color", text_color)
	button.add_theme_color_override("font_hover_color", text_color)
	button.add_theme_color_override("font_pressed_color", text_color)

func _on_food_pressed(food: String, button: Button) -> void:
	if selected.has(food):
		selected.erase(food)
		button.modulate = Color.WHITE
	elif selected.size() < 2:
		selected.append(food)
		button.modulate = Color("#B8FFD0")
	else:
		message_label.text = "Choose only two ingredients. Clear to start again."
		return

	var first := selected[0] if selected.size() > 0 else "None"
	var second := selected[1] if selected.size() > 1 else "None"
	selection_label.text = "Your ingredients: " + first + " + " + second

func _on_mix_pressed() -> void:
	if selected.size() != 2:
		message_label.text = "Choose two ingredients first!"
		return

	var pair := selected.duplicate()
	pair.sort()
	var key: String = str(pair[0]) + "|" + str(pair[1])

	if recipes.has(key):
		var dish: String = recipes[key]
		if not discoveries.has(key):
			discoveries.append(key)
			score += 10
			message_label.text = "✨ New discovery: " + dish + "! +10 points!"
		else:
			message_label.text = "You already discovered " + dish + "!"
	else:
		message_label.text = "Interesting experiment! Try another combination."

	score_label.text = "⭐ Score: " + str(score)
	recipe_label.text = "📖 Recipes discovered: " + str(discoveries.size()) + " / 6"
	_on_clear_pressed()

func _on_clear_pressed() -> void:
	selected.clear()
	for button in food_buttons:
		button.modulate = Color.WHITE
	selection_label.text = "Your ingredients: None + None"
