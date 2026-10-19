extends Control
# FOODIVERSE v2  (Godot 4.x)
# Attach to a root node of type Control.
# Features: story map, 6 levels, timer, lives, customer orders, hints,
# 3-ingredient recipes, rarity, recipe book, achievements, daily challenge,
# mini-games, mascot, fun facts, sounds, confetti and save/load.

const SAVE_PATH := "user://foodiverse.cfg"
const RARITY_POINTS := {"Common": 10, "Rare": 20, "Legendary": 40}
const RARITY_COLORS := {"Common": "#7A7A7A", "Rare": "#2F7BD9", "Legendary": "#D18F00"}

# ---------------------------------------------------------------
# LEVEL DATA   foods: [name, emoji, color]   recipes: key -> [dish, rarity, fun fact]
# Recipe keys are ingredient names sorted A-Z and joined with "|"
# ---------------------------------------------------------------
var levels: Array = [
	{
		"name": "Alleppey Backwaters", "icon": "🛶", "theme": "Kerala Kitchen",
		"time": 120, "lives": 8, "max_pick": 2,
		"foods": [["Appam", "🥞", "#F4C77A"], ["Fish Curry", "🐟", "#F29B78"], ["Pasta", "🍝", "#F5D58A"],
			["Cheese", "🧀", "#F1D76B"], ["Mango", "🥭", "#F7B84B"], ["Chocolate", "🍫", "#C99A85"]],
		"recipes": {
			"Appam|Cheese": ["Cheesy Appam", "Common", "Appam is a lacy, fermented rice pancake from Kerala."],
			"Fish Curry|Pasta": ["Kerala Fish Curry Pasta", "Rare", "Kerala fish curry gets its tang from kudampuli, also called Malabar tamarind."],
			"Chocolate|Mango": ["Mango Chocolate Fusion", "Common", "Mangoes are a summer favourite all over Kerala."],
			"Appam|Mango": ["Sweet Mango Appam", "Common", "Appam is often eaten with sweet coconut milk too."],
			"Cheese|Pasta": ["Cheesy Pasta", "Common", "Pasta comes from Italy and loves cheese."],
			"Chocolate|Pasta": ["Chocolate Pasta Surprise", "Rare", "Sweet pasta dishes exist in many cuisines."],
		},
	},
	{
		"name": "Kozhikode Beach", "icon": "🏖️", "theme": "Malabar Coast",
		"time": 110, "lives": 8, "max_pick": 2,
		"foods": [["Halwa", "🍬", "#F2A65A"], ["Prawn", "🦐", "#F5A38C"], ["Coconut", "🥥", "#E3D5C4"],
			["Rice", "🍚", "#F3EBD8"], ["Chilli", "🌶️", "#EF8A78"], ["Egg", "🥚", "#F7E2B0"]],
		"recipes": {
			"Coconut|Prawn": ["Coconut Prawn Curry", "Common", "Kerala is often linked to 'kera', the Malayalam word for coconut."],
			"Chilli|Prawn": ["Spicy Prawn Roast", "Common", "Kerala roasts use lots of onion, chilli and curry leaves."],
			"Egg|Rice": ["Egg Fried Rice", "Common", "Rice is the heart of a Kerala meal."],
			"Chilli|Egg": ["Spicy Egg Roast", "Common", "Egg roast is a classic side for appam and parotta."],
			"Coconut|Rice": ["Coconut Rice", "Rare", "Coconut oil is the traditional cooking oil in Kerala."],
			"Coconut|Halwa": ["Coconut Halwa", "Rare", "Kozhikode is famous for its colourful halwa."],
		},
	},
	{
		"name": "Munnar Tea Hills", "icon": "🍵", "theme": "Spice & Tea Hills",
		"time": 100, "lives": 7, "max_pick": 2,
		"foods": [["Tea", "🍵", "#C9D9A5"], ["Milk", "🥛", "#F4EEE4"], ["Cardamom", "🌿", "#B9D98F"],
			["Banana", "🍌", "#F7E27A"], ["Honey", "🍯", "#F2C14E"], ["Ginger", "🌱", "#E6C98F"]],
		"recipes": {
			"Milk|Tea": ["Kerala Chai", "Common", "Munnar is known for its rolling tea plantations."],
			"Cardamom|Tea": ["Cardamom Tea", "Rare", "Cardamom is called the queen of spices, and Kerala's hills grow it."],
			"Ginger|Tea": ["Ginger Tea", "Common", "Ginger tea is a popular rainy day drink."],
			"Banana|Honey": ["Honey Banana", "Common", "Bananas are used in dozens of Kerala snacks."],
			"Banana|Milk": ["Banana Milkshake", "Common", "Kerala has many banana varieties."],
			"Cardamom|Milk": ["Cardamom Milk", "Rare", "A pinch of cardamom makes warm milk taste special."],
		},
	},
	{
		"name": "World Kitchen", "icon": "🌍", "theme": "Kerala x World",
		"time": 100, "lives": 7, "max_pick": 2,
		"foods": [["Dosa", "🫓", "#F2D49B"], ["Paneer", "🧈", "#F6E7B4"], ["Tortilla", "🌮", "#F0C27B"],
			["Avocado", "🥑", "#B9D98F"], ["Noodles", "🍜", "#F4D98C"], ["Tomato", "🍅", "#F08C7A"]],
		"recipes": {
			"Dosa|Paneer": ["Paneer Dosa", "Common", "Dosa is a crisp fermented crepe loved across South India."],
			"Paneer|Tortilla": ["Paneer Tacos", "Rare", "Indian-Mexican fusion is a growing street food trend."],
			"Dosa|Tortilla": ["Dosa Quesadilla", "Rare", "Both dosa and tortilla are thin griddle breads."],
			"Avocado|Tortilla": ["Avocado Taco", "Common", "Avocado is a star ingredient in Mexican food."],
			"Noodles|Tomato": ["Tomato Noodles", "Common", "Noodles travelled the world from East Asia."],
			"Dosa|Noodles": ["Noodle Dosa", "Legendary", "Fusion cooking mixes traditions in surprising ways."],
		},
	},
	{
		"name": "Onam Sadya", "icon": "🍌", "theme": "SPECIAL: 3-ingredient feast!",
		"time": 160, "lives": 10, "max_pick": 3,
		"foods": [["Rice", "🍚", "#F3EBD8"], ["Sambar", "🥣", "#F0B06A"], ["Payasam", "🍮", "#F6D58E"],
			["Banana Chips", "🍌", "#F7E27A"], ["Pappadam", "🫓", "#EBCB8B"], ["Avial", "🥗", "#B9D98F"]],
		"recipes": {
			"Rice|Sambar": ["Rice & Sambar", "Common", "Sambar is a lentil and vegetable stew."],
			"Pappadam|Payasam": ["Sweet Crunch Pappadam", "Rare", "Payasam is a sweet milk or jaggery pudding."],
			"Avial|Rice|Sambar": ["Classic Sadya Meal", "Legendary", "Onam Sadya is a vegetarian feast served on a banana leaf."],
			"Banana Chips|Pappadam|Rice": ["Crunchy Sadya Plate", "Rare", "Banana chips are fried in coconut oil."],
			"Avial|Payasam|Rice": ["Feast Combo", "Legendary", "A full sadya can have more than 20 dishes."],
			"Banana Chips|Payasam|Sambar": ["Sweet-Savoury Sadya", "Rare", "Sadya mixes sweet, salty, sour and spicy flavours."],
		},
	},
	{
		"name": "Street Food Night", "icon": "🌃", "theme": "SPECIAL: Biryani Battle!",
		"time": 170, "lives": 10, "max_pick": 3,
		"foods": [["Parotta", "🫓", "#EBCB8B"], ["Chicken", "🍗", "#E9A96B"], ["Biryani", "🍛", "#F2C98A"],
			["Egg", "🥚", "#F7E2B0"], ["Onion", "🧅", "#E8C6D6"], ["Chilli", "🌶️", "#EF8A78"]],
		"recipes": {
			"Chicken|Parotta": ["Parotta & Chicken Curry", "Common", "Malabar parotta is a flaky, layered flatbread."],
			"Biryani|Chicken": ["Chicken Biryani", "Rare", "Thalassery and Malabar biryani are famous in Kerala."],
			"Biryani|Egg": ["Egg Biryani", "Common", "Eggs make a quick, tasty biryani."],
			"Chicken|Chilli": ["Chilli Chicken", "Common", "Indo-Chinese dishes are big in street food."],
			"Egg|Onion|Parotta": ["Egg Kothu Parotta", "Legendary", "Kothu means 'chopped'; it's made by chopping parotta on a hot griddle."],
			"Chicken|Onion|Parotta": ["Chicken Kothu Parotta", "Legendary", "You can often hear kothu being made by the clanging of metal blades."],
			"Biryani|Chicken|Chilli": ["Fiery Biryani Battle", "Legendary", "Biryani is layered rice and meat cooked slowly in steam."],
		},
	},
]

var achievement_defs := {
	"first_dish": ["First Dish", "Discover your first recipe", "🍽️"],
	"ten_dishes": ["Home Cook", "Discover 10 recipes", "👩‍🍳"],
	"all_dishes": ["Master Chef", "Discover every recipe", "👑"],
	"legendary": ["Legend Hunter", "Discover a Legendary dish", "🏅"],
	"perfect": ["Flawless", "Clear a level without a single wrong mix", "💎"],
	"speedy": ["Speed Cook", "Clear a level with over half the time left", "⚡"],
	"stars10": ["Star Collector", "Earn 10 stars", "🌟"],
	"all_levels": ["World Traveller", "Clear every level", "🗺️"],
	"daily": ["Daily Chef", "Complete a Daily Challenge", "📅"],
	"minigames": ["Kitchen Champ", "Win 3 mini-games", "🎮"],
	"sadya": ["Sadya Star", "Clear the Onam Sadya level", "🍌"],
}

var good_lines := ["Adipoli! Smells wonderful!", "Kollaam! Keep cooking, chef!", "Super! Ammachi is proud!", "Wow, that's a tasty find!"]
var bad_lines := ["Hmm, that doesn't taste right...", "Ayyo! Try another mix!", "Oops! Even Ammachi burns the curry sometimes.", "Not that one, mone/mole!"]
var customer_emojis := ["🙋", "🙋‍♂️", "👵", "👴", "🧒", "💁"]

# ---------------------------------------------------------------
# STATE
# ---------------------------------------------------------------
var all_recipes: Array = []          # [level_index, key]
var score := 0
var level_stars: Array = []
var book: Dictionary = {}            # "lvl:key" -> true
var ach_unlocked: Dictionary = {}
var minigames_won := 0
var daily_done_date := ""

var current_level := 0
var daily_mode := false
var active_recipes: Dictionary = {}
var discoveries: Array = []
var selected: Array = []
var tried_wrong: Dictionary = {}
var lives := 5
var lives_max := 5
var time_left := 0.0
var time_total := 1.0
var playing := false
var wrong_mixes := 0
var hints_left := 3
var order_key := ""
var max_pick := 2
var food_buttons: Dictionary = {}

# ---------------------------------------------------------------
# UI REFERENCES
# ---------------------------------------------------------------
var screens: Dictionary = {}
var map_box: VBoxContainer
var book_box: VBoxContainer
var ach_box: VBoxContainer
var mini_box: VBoxContainer
var game_box: VBoxContainer
var fx_layer: Control
var toast: Label
var toast_tween: Tween
var audio: AudioStreamPlayer
var sfx: Dictionary = {}

var level_label: Label
var timer_label: Label
var timer_bar: ProgressBar
var lives_label: Label
var score_label: Label
var mascot_label: Label
var bubble_label: Label
var order_label: Label
var recipe_label: Label
var progress_bar: ProgressBar
var grid: GridContainer
var selection_label: Label
var mix_button: Button
var hint_button: Button
var message_label: Label
var result_box: VBoxContainer

# mini-game state
var mini_mode := ""
var mini_running := false
var mini_pos := 0.0
var mini_dir := 1.0
var mini_speed := 1.0
var mini_flips := 0
var mini_hits := 0
var mini_marker: ColorRect
var mini_track: Control
var mini_status: Label
var mini_time := 0.0
var mini_taps := 0
var mini_started := false
var mini_seq: Array = []
var mini_input := 0
var mini_stir_buttons: Array = []
var mini_main_btn: Button


# ===============================================================
# STARTUP
# ===============================================================
func _ready() -> void:
	randomize()
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	for i in levels.size():
		level_stars.append(0)
		var recipes: Dictionary = levels[i]["recipes"]
		for key in recipes:
			all_recipes.append([i, key])
	load_game()
	_build_sounds()
	_build_ui()
	show_screen("map")


func _build_ui() -> void:
	var bg := ColorRect.new()
	bg.color = Color("#FFF4E3")
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	map_box = _make_screen("map")
	_build_game_screen()
	book_box = _make_screen("book")
	ach_box = _make_screen("ach")
	mini_box = _make_screen("mini")

	fx_layer = Control.new()
	fx_layer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	fx_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fx_layer)

	toast = Label.new()
	toast.set_anchors_and_offsets_preset(Control.PRESET_TOP_WIDE)
	toast.offset_left = 20
	toast.offset_right = -20
	toast.offset_top = 8
	toast.offset_bottom = 66
	toast.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	toast.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	toast.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	toast.add_theme_font_size_override("font_size", 17)
	toast.add_theme_color_override("font_color", Color.WHITE)
	var tsb := StyleBoxFlat.new()
	tsb.bg_color = Color("#23865B")
	tsb.set_corner_radius_all(14)
	tsb.set_content_margin_all(8)
	toast.add_theme_stylebox_override("normal", tsb)
	toast.visible = false
	fx_layer.add_child(toast)

	audio = AudioStreamPlayer.new()
	add_child(audio)


func _make_screen(screen_name: String) -> VBoxContainer:
	var scroll := ScrollContainer.new()
	scroll.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	add_child(scroll)
	var margin := MarginContainer.new()
	margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin.add_theme_constant_override("margin_left", 24)
	margin.add_theme_constant_override("margin_right", 24)
	margin.add_theme_constant_override("margin_top", 18)
	margin.add_theme_constant_override("margin_bottom", 24)
	scroll.add_child(margin)
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 10)
	margin.add_child(box)
	screens[screen_name] = scroll
	return box


func show_screen(screen_name: String) -> void:
	for k in screens:
		screens[k].visible = (k == screen_name)
	if screen_name == "map":
		playing = false
		mini_running = false
		refresh_map()
	elif screen_name == "book":
		refresh_book()
	elif screen_name == "ach":
		refresh_ach()


# ===============================================================
# SMALL UI HELPERS
# ===============================================================
func _label(text: String, font_size: int = 16, color: String = "#62483C", center: bool = true, wrap: bool = true) -> Label:
	var l := Label.new()
	l.text = text
	l.add_theme_font_size_override("font_size", font_size)
	l.add_theme_color_override("font_color", Color(color))
	if wrap:
		l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	if center:
		l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	return l


func _style_button(button: Button, bg_color: Color, text_color: Color) -> void:
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

	var disabled := normal.duplicate() as StyleBoxFlat
	disabled.bg_color = Color("#D9D0C4")
	disabled.border_color = Color("#BDB3A6")
	button.add_theme_stylebox_override("disabled", disabled)

	button.add_theme_color_override("font_color", text_color)
	button.add_theme_color_override("font_hover_color", text_color)
	button.add_theme_color_override("font_pressed_color", text_color)
	button.add_theme_color_override("font_disabled_color", Color("#8C8378"))


func _button(text: String, bg: String, fg: String = "#51392D", min_h: int = 52, font_size: int = 18) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(0, min_h)
	b.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	b.add_theme_font_size_override("font_size", font_size)
	_style_button(b, Color(bg), Color(fg))
	return b


func _make_card(border: Color) -> PanelContainer:
	var p := PanelContainer.new()
	var sb := StyleBoxFlat.new()
	sb.bg_color = Color("#FFFBF3")
	sb.set_corner_radius_all(12)
	sb.set_border_width_all(3)
	sb.border_color = border
	sb.set_content_margin_all(10)
	p.add_theme_stylebox_override("panel", sb)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 4)
	p.add_child(v)
	return p


func _clear_children(node: Node) -> void:
	for c in node.get_children():
		c.queue_free()


func _join(arr: Array, sep: String) -> String:
	var out := ""
	for i in arr.size():
		if i > 0:
			out += sep
		out += str(arr[i])
	return out


func _make_key(items: Array) -> String:
	var pair: Array = items.duplicate()
	pair.sort()
	return _join(pair, "|")


# ===============================================================
# JUICE: SOUND, BOUNCE, CONFETTI, TOAST
# ===============================================================
func make_melody(freqs: Array, note_dur: float, vol: float = 0.35) -> AudioStreamWAV:
	var rate := 22050
	var per := int(rate * note_dur)
	var data := PackedByteArray()
	data.resize(per * freqs.size() * 2)
	var idx := 0
	for f in freqs:
		for i in per:
			var t := float(i) / rate
			var env := 1.0 - float(i) / per
			var v := sin(TAU * float(f) * t) * vol * env
			data.encode_s16(idx * 2, int(v * 32767.0))
			idx += 1
	var s := AudioStreamWAV.new()
	s.format = AudioStreamWAV.FORMAT_16_BITS
	s.mix_rate = rate
	s.stereo = false
	s.data = data
	return s


func _build_sounds() -> void:
	sfx["pick"] = make_melody([660.0], 0.07)
	sfx["mix"] = make_melody([440.0, 550.0], 0.07)
	sfx["good"] = make_melody([523.0, 659.0, 784.0], 0.09)
	sfx["star"] = make_melody([784.0, 988.0, 1175.0, 1568.0], 0.09)
	sfx["bad"] = make_melody([220.0, 165.0], 0.12)
	sfx["win"] = make_melody([523.0, 659.0, 784.0, 1047.0, 1319.0], 0.11)
	sfx["lose"] = make_melody([392.0, 330.0, 262.0, 196.0], 0.14)


func play_sfx(sound_name: String) -> void:
	if sfx.has(sound_name) and audio != null:
		audio.stream = sfx[sound_name]
		audio.play()


func bounce(c: Control) -> void:
	c.pivot_offset = c.size / 2.0
	var tw := create_tween()
	tw.tween_property(c, "scale", Vector2(1.12, 1.12), 0.07)
	tw.tween_property(c, "scale", Vector2.ONE, 0.10)


func confetti(count: int = 24) -> void:
	var center := size / 2.0
	var emojis := ["⭐", "✨", "🎉", "🍛", "🥭", "🌟"]
	for i in count:
		var l := Label.new()
		l.text = emojis[randi() % emojis.size()]
		l.add_theme_font_size_override("font_size", 28)
		l.position = center
		fx_layer.add_child(l)
		var target := center + Vector2(randf_range(-220, 220), randf_range(-340, 160))
		var tw := create_tween()
		tw.set_parallel(true)
		tw.tween_property(l, "position", target, 0.9).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tw.tween_property(l, "modulate:a", 0.0, 0.9)
		tw.finished.connect(l.queue_free)


func show_toast(text: String) -> void:
	toast.text = text
	toast.visible = true
	toast.modulate.a = 1.0
	if toast_tween != null and toast_tween.is_valid():
		toast_tween.kill()
	toast_tween = create_tween()
	toast_tween.tween_interval(2.6)
	toast_tween.tween_property(toast, "modulate:a", 0.0, 0.5)
	toast_tween.tween_callback(func(): toast.visible = false)


# ===============================================================
# SAVE / LOAD
# ===============================================================
func save_game() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("p", "score", score)
	cfg.set_value("p", "level_stars", level_stars)
	cfg.set_value("p", "book", book)
	cfg.set_value("p", "ach", ach_unlocked)
	cfg.set_value("p", "mg", minigames_won)
	cfg.set_value("p", "daily", daily_done_date)
	cfg.save(SAVE_PATH)


func load_game() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return
	score = int(cfg.get_value("p", "score", 0))
	var ls: Array = cfg.get_value("p", "level_stars", [])
	for i in mini(ls.size(), level_stars.size()):
		level_stars[i] = int(ls[i])
	book = cfg.get_value("p", "book", {})
	ach_unlocked = cfg.get_value("p", "ach", {})
	minigames_won = int(cfg.get_value("p", "mg", 0))
	daily_done_date = str(cfg.get_value("p", "daily", ""))


func total_stars() -> int:
	var t := 0
	for s in level_stars:
		t += int(s)
	return t


# ===============================================================
# ACHIEVEMENTS
# ===============================================================
func unlock(id: String) -> void:
	if ach_unlocked.has(id) or not achievement_defs.has(id):
		return
	ach_unlocked[id] = true
	var d: Array = achievement_defs[id]
	show_toast("%s Achievement unlocked: %s" % [d[2], d[0]])
	play_sfx("star")
	save_game()


func check_achievements() -> void:
	if book.size() >= 1:
		unlock("first_dish")
	if book.size() >= 10:
		unlock("ten_dishes")
	if book.size() >= all_recipes.size():
		unlock("all_dishes")
	if total_stars() >= 10:
		unlock("stars10")
	var all_clear := true
	for s in level_stars:
		if int(s) <= 0:
			all_clear = false
	if all_clear:
		unlock("all_levels")
	if int(level_stars[4]) > 0:
		unlock("sadya")
	if minigames_won >= 3:
		unlock("minigames")


func refresh_ach() -> void:
	_clear_children(ach_box)
	var back := _button("⬅️ Back to map", "#E8D8C6", "#62483C", 44, 16)
	back.pressed.connect(func(): show_screen("map"))
	ach_box.add_child(back)
	ach_box.add_child(_label("🏅 ACHIEVEMENTS", 30, "#A63D24"))
	ach_box.add_child(_label("Unlocked %d / %d" % [ach_unlocked.size(), achievement_defs.size()], 16))
	for id in achievement_defs:
		var d: Array = achievement_defs[id]
		var got: bool = ach_unlocked.has(id)
		var card := _make_card(Color("#D18F00") if got else Color("#CFC6BA"))
		var inner := card.get_child(0) as VBoxContainer
		if got:
			inner.add_child(_label("%s  %s" % [d[2], d[0]], 19, "#A63D24", false))
		else:
			inner.add_child(_label("🔒  %s" % d[0], 19, "#8C8378", false))
		inner.add_child(_label(d[1], 14, "#62483C", false))
		ach_box.add_child(card)


# ===============================================================
# STORY MAP
# ===============================================================
func is_unlocked(i: int) -> bool:
	return i == 0 or int(level_stars[i - 1]) > 0


func refresh_map() -> void:
	_clear_children(map_box)
	map_box.add_child(_label("🍳 FOODIVERSE 🌎", 34, "#A63D24"))
	map_box.add_child(_label("KERALA × WORLD  •  MIX. DISCOVER. COLLECT!", 13, "#77594B"))
	map_box.add_child(_label("⭐ Score %d   🌟 Stars %d   📖 Dishes %d/%d" % [score, total_stars(), book.size(), all_recipes.size()], 15, "#62483C"))

	var today := Time.get_date_string_from_system()
	var daily_btn: Button
	if daily_done_date == today:
		daily_btn = _button("✅ Daily Challenge done! Come back tomorrow", "#D9D0C4", "#62483C", 52, 15)
		daily_btn.disabled = true
	else:
		daily_btn = _button("📅 DAILY CHALLENGE: find today's secret dish!", "#E8A317", "#51392D", 56, 16)
		daily_btn.pressed.connect(func(): start_level(0, true))
	map_box.add_child(daily_btn)

	map_box.add_child(_label("🗺️ STORY MAP", 20, "#23865B"))
	for i in levels.size():
		var lv: Dictionary = levels[i]
		var btn: Button
		if is_unlocked(i):
			var st: int = int(level_stars[i])
			var star_txt := "⭐".repeat(st) + "☆".repeat(3 - st)
			btn = _button("%s  %d. %s   %s\n%s" % [lv["icon"], i + 1, lv["name"], star_txt, lv["theme"]], "#F7D9A8", "#51392D", 68, 16)
			btn.pressed.connect(func(): start_level(i, false))
		else:
			btn = _button("🔒  %d. %s\nEarn a star on the previous level" % [i + 1, lv["name"]], "#D9D0C4", "#8C8378", 68, 15)
			btn.disabled = true
		map_box.add_child(btn)
		if i < levels.size() - 1:
			map_box.add_child(_label("⋮", 16, "#C99A85"))

	var book_btn := _button("📖 Recipe Book", "#23865B", "#FFFFFF", 52, 18)
	book_btn.pressed.connect(func(): show_screen("book"))
	map_box.add_child(book_btn)
	var ach_btn := _button("🏅 Achievements", "#7A5CC2", "#FFFFFF", 52, 18)
	ach_btn.pressed.connect(func(): show_screen("ach"))
	map_box.add_child(ach_btn)


# ===============================================================
# RECIPE BOOK
# ===============================================================
func refresh_book() -> void:
	_clear_children(book_box)
	var back := _button("⬅️ Back to map", "#E8D8C6", "#62483C", 44, 16)
	back.pressed.connect(func(): show_screen("map"))
	book_box.add_child(back)
	book_box.add_child(_label("📖 RECIPE BOOK", 30, "#A63D24"))
	book_box.add_child(_label("Collected %d / %d dishes" % [book.size(), all_recipes.size()], 16))
	for i in levels.size():
		var lv: Dictionary = levels[i]
		book_box.add_child(_label("%s %s" % [lv["icon"], lv["name"]], 20, "#23865B"))
		var recipes: Dictionary = lv["recipes"]
		for key in recipes:
			var info: Array = recipes[key]
			var rarity: String = info[1]
			var found: bool = book.has("%d:%s" % [i, key])
			var card := _make_card(Color(RARITY_COLORS[rarity]))
			var inner := card.get_child(0) as VBoxContainer
			var parts: PackedStringArray = str(key).split("|")
			if found:
				inner.add_child(_label("%s  [%s]" % [info[0], rarity], 18, RARITY_COLORS[rarity], false))
				inner.add_child(_label(" + ".join(parts), 14, "#62483C", false))
				inner.add_child(_label("💡 " + str(info[2]), 13, "#77594B", false))
			else:
				inner.add_child(_label("❓ ???  [%s]" % rarity, 18, "#8C8378", false))
				inner.add_child(_label("Uses %d ingredients" % parts.size(), 14, "#8C8378", false))
			book_box.add_child(card)


# ===============================================================
# GAME SCREEN
# ===============================================================
func _build_game_screen() -> void:
	game_box = _make_screen("game")

	var top := HBoxContainer.new()
	game_box.add_child(top)
	var map_btn := _button("🗺️", "#E8D8C6", "#62483C", 40, 16)
	map_btn.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	map_btn.pressed.connect(func(): show_screen("map"))
	top.add_child(map_btn)
	level_label = _label("", 17, "#23865B", false, false)
	level_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	top.add_child(level_label)
	timer_label = _label("", 20, "#A63D24", false, false)
	top.add_child(timer_label)

	timer_bar = ProgressBar.new()
	timer_bar.custom_minimum_size = Vector2(0, 12)
	timer_bar.show_percentage = false
	game_box.add_child(timer_bar)

	var stats := HBoxContainer.new()
	game_box.add_child(stats)
	lives_label = _label("", 17, "#A63D24", false, false)
	lives_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	stats.add_child(lives_label)
	score_label = _label("", 18, "#A63D24", false, false)
	stats.add_child(score_label)

	# Mascot + speech bubble
	var mascot_row := HBoxContainer.new()
	mascot_row.add_theme_constant_override("separation", 10)
	game_box.add_child(mascot_row)
	mascot_label = _label("👵", 46, "#000000", false, false)
	mascot_row.add_child(mascot_label)
	var bubble := _make_card(Color("#E8B7A8"))
	bubble.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	mascot_row.add_child(bubble)
	bubble_label = _label("", 15, "#51392D", false)
	(bubble.get_child(0) as VBoxContainer).add_child(bubble_label)

	order_label = _label("", 16, "#7A5CC2")
	game_box.add_child(order_label)

	recipe_label = _label("", 15, "#62483C")
	game_box.add_child(recipe_label)
	progress_bar = ProgressBar.new()
	progress_bar.custom_minimum_size = Vector2(0, 14)
	progress_bar.show_percentage = false
	game_box.add_child(progress_bar)

	grid = GridContainer.new()
	grid.columns = 2
	grid.add_theme_constant_override("h_separation", 12)
	grid.add_theme_constant_override("v_separation", 12)
	game_box.add_child(grid)

	selection_label = _label("", 16, "#62483C")
	game_box.add_child(selection_label)

	mix_button = _button("✨  MIX & DISCOVER!  ✨", "#23865B", "#FFFFFF", 64, 21)
	mix_button.pressed.connect(_on_mix_pressed)
	game_box.add_child(mix_button)

	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 10)
	game_box.add_child(row)
	var clear_button := _button("↻ Clear", "#E8D8C6", "#62483C", 46, 16)
	clear_button.pressed.connect(_on_clear_pressed)
	row.add_child(clear_button)
	hint_button = _button("💡 Hint", "#F2C14E", "#51392D", 46, 16)
	hint_button.pressed.connect(_on_hint_pressed)
	row.add_child(hint_button)

	message_label = _label("", 15, "#A63D24")
	game_box.add_child(message_label)

	result_box = VBoxContainer.new()
	result_box.add_theme_constant_override("separation", 8)
	result_box.visible = false
	game_box.add_child(result_box)


func start_level(index: int, daily: bool = false) -> void:
	daily_mode = daily
	var lv: Dictionary
	if daily:
		var pick: Array = daily_pick()
		current_level = int(pick[0])
		lv = levels[current_level]
		var k: String = pick[1]
		active_recipes = {}
		active_recipes[k] = (lv["recipes"] as Dictionary)[k]
		time_total = 60.0
		lives_max = 4
		hints_left = 2
	else:
		current_level = index
		lv = levels[current_level]
		active_recipes = (lv["recipes"] as Dictionary).duplicate()
		time_total = float(lv["time"])
		lives_max = int(lv["lives"])
		hints_left = 3

	max_pick = int(lv["max_pick"])
	lives = lives_max
	time_left = time_total
	discoveries.clear()
	selected.clear()
	tried_wrong.clear()
	wrong_mixes = 0
	order_key = ""

	# rebuild ingredient cards
	_clear_children(grid)
	food_buttons.clear()
	for item in lv["foods"]:
		var food: String = item[0]
		var b := Button.new()
		b.text = "%s  %s" % [item[1], food]
		b.custom_minimum_size = Vector2(150, 62)
		b.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		b.add_theme_font_size_override("font_size", 17)
		_style_button(b, Color(item[2]), Color("#51392D"))
		b.pressed.connect(_on_food_pressed.bind(food, b))
		grid.add_child(b)
		food_buttons[food] = b

	_clear_children(result_box)
	result_box.visible = false
	mix_button.disabled = false
	hint_button.disabled = false

	if daily:
		level_label.text = "📅 DAILY: %s %s" % [lv["icon"], lv["name"]]
		message_label.text = "Find today's secret dish before time runs out!"
		say("Today's secret dish is hiding in %s. Find it!" % lv["name"])
	else:
		level_label.text = "%s L%d: %s" % [lv["icon"], current_level + 1, lv["name"]]
		message_label.text = "Discover all %d dishes. Wrong mixes cost a life!" % active_recipes.size()
		if max_pick == 3:
			say("%s! You can mix up to THREE ingredients here." % lv["theme"])
		else:
			say("Welcome to %s! Mix two ingredients to find dishes." % lv["name"])

	new_order()
	_update_selection()
	update_hud()
	update_timer()
	show_screen("game")
	playing = true


func daily_pick() -> Array:
	var d := Time.get_date_string_from_system()
	var idx: int = absi(d.hash()) % all_recipes.size()
	return all_recipes[idx]


func say(text: String) -> void:
	bubble_label.text = text
	bounce(mascot_label)


func update_hud() -> void:
	score_label.text = "⭐ %d" % score
	lives_label.text = "❤️".repeat(maxi(lives, 0)) + "🖤".repeat(maxi(lives_max - lives, 0))
	recipe_label.text = "📖 Dishes found: %d / %d" % [discoveries.size(), active_recipes.size()]
	progress_bar.max_value = active_recipes.size()
	progress_bar.value = discoveries.size()
	hint_button.text = "💡 Hint (%d) -10pts" % hints_left


func update_timer() -> void:
	timer_label.text = "⏱️ %d" % int(ceil(time_left))
	timer_bar.max_value = time_total
	timer_bar.value = time_left
	var c := Color("#A63D24") if time_left < 10.0 else Color("#23865B")
	timer_label.add_theme_color_override("font_color", c)


func _update_selection() -> void:
	if selected.is_empty():
		selection_label.text = "🧺 Your mix: None"
	else:
		selection_label.text = "🧺 Your mix: " + _join(selected, " + ")


# ---------------- customer orders ----------------
func new_order() -> void:
	var remaining: Array = []
	for k in active_recipes:
		if not discoveries.has(k):
			remaining.append(k)
	if remaining.is_empty():
		order_key = ""
		order_label.text = ""
		return
	order_key = remaining[randi() % remaining.size()]
	var info: Array = active_recipes[order_key]
	var n: int = order_key.split("|").size()
	order_label.text = "%s Customer wants: %s!  (%d ingredients, +15 bonus)" % [
		customer_emojis[randi() % customer_emojis.size()], info[0], n]


# ---------------- input ----------------
func _on_food_pressed(food: String, button: Button) -> void:
	if not playing:
		return
	play_sfx("pick")
	bounce(button)
	if selected.has(food):
		selected.erase(food)
		button.modulate = Color.WHITE
	elif selected.size() < max_pick:
		selected.append(food)
		button.modulate = Color("#B8FFD0")
	else:
		message_label.text = "Max %d ingredients here. Clear to start again." % max_pick
		return
	_update_selection()


func _on_clear_pressed() -> void:
	selected.clear()
	for k in food_buttons:
		(food_buttons[k] as Button).modulate = Color.WHITE
	_update_selection()


func _on_hint_pressed() -> void:
	if not playing:
		return
	if hints_left <= 0:
		say("No hints left, chef!")
		return
	var target := order_key
	if target == "":
		return
	hints_left -= 1
	score = maxi(0, score - 10)
	var parts: PackedStringArray = target.split("|")
	var pick: String = parts[randi() % parts.size()]
	var b: Button = food_buttons[pick]
	var prev := b.modulate
	var tw := create_tween()
	tw.tween_property(b, "modulate", Color("#FFE066"), 0.2)
	tw.tween_interval(1.6)
	tw.tween_property(b, "modulate", prev, 0.2)
	bounce(b)
	say("Psst... the customer's dish uses %s!" % pick)
	update_hud()


func _on_mix_pressed() -> void:
	if not playing:
		return
	if selected.size() < 2:
		say("Pick at least two ingredients first!")
		return
	bounce(mix_button)
	var key := _make_key(selected)

	if active_recipes.has(key):
		var info: Array = active_recipes[key]
		if discoveries.has(key):
			message_label.text = "You already made %s!" % info[0]
			say("We already cooked that one!")
			play_sfx("mix")
		else:
			discoveries.append(key)
			var rarity: String = info[1]
			var pts: int = RARITY_POINTS[rarity]
			score += pts
			book["%d:%s" % [current_level, key]] = true
			var msg := "✨ New dish: %s [%s]  +%d pts" % [info[0], rarity, pts]
			if key == order_key:
				score += 15
				time_left += 5.0
				time_total = maxf(time_total, time_left)
				msg += "\n🎯 Order served! +15 pts, +5 seconds"
			msg += "\n💡 " + str(info[2])
			message_label.text = msg
			say(good_lines[randi() % good_lines.size()])
			if rarity == "Common":
				play_sfx("good")
			else:
				play_sfx("star")
				confetti(18)
			if rarity == "Legendary":
				unlock("legendary")
				confetti(30)
			if key == order_key or order_key == "" or discoveries.has(order_key):
				new_order()
			check_achievements()
			save_game()
	else:
		if tried_wrong.has(key):
			message_label.text = "You already tried that mix. No life lost, try another!"
			say("Same mix again? Try something new!")
		else:
			tried_wrong[key] = true
			lives -= 1
			wrong_mixes += 1
			play_sfx("bad")
			message_label.text = "💥 That mix doesn't work. -1 life"
			say(bad_lines[randi() % bad_lines.size()])
			var tw := create_tween()
			message_label.modulate = Color("#FF6B5A")
			tw.tween_property(message_label, "modulate", Color.WHITE, 0.5)

	_on_clear_pressed()
	update_hud()

	if lives <= 0:
		finish_level(false, "lives")
	elif discoveries.size() >= active_recipes.size():
		finish_level(true)


# ---------------- end of level ----------------
func _add_result_button(text: String, bg: String, fg: String, action: Callable) -> void:
	var b := _button(text, bg, fg, 54, 18)
	b.pressed.connect(action)
	result_box.add_child(b)


func finish_level(won: bool, reason: String = "") -> void:
	playing = false
	mix_button.disabled = true
	hint_button.disabled = true
	_clear_children(result_box)
	result_box.visible = true

	if won:
		var stars := 1
		if lives >= int(ceil(lives_max * 0.5)):
			stars += 1
		if time_left >= time_total * 0.3:
			stars += 1
		score += 50
		var text := "🏆 LEVEL COMPLETE!  +50 bonus"
		if daily_mode:
			score += 100
			daily_done_date = Time.get_date_string_from_system()
			unlock("daily")
			text = "📅 DAILY CHALLENGE COMPLETE!  +150 bonus"
		else:
			text += "\n" + "⭐".repeat(stars) + "☆".repeat(3 - stars)
			if stars > int(level_stars[current_level]):
				level_stars[current_level] = stars
			if wrong_mixes == 0:
				unlock("perfect")
			if time_left >= time_total * 0.5:
				unlock("speedy")
		result_box.add_child(_label(text, 22, "#23865B"))
		play_sfx("win")
		confetti(40)
		say("Superb, chef! Ammachi is so proud!")

		if not daily_mode and current_level < levels.size() - 1:
			var nxt: String = levels[current_level + 1]["name"]
			_add_result_button("➡️ NEXT LEVEL: %s" % nxt.to_upper(), "#E8A317", "#51392D",
				func(): start_level(current_level + 1, false))
		elif not daily_mode:
			result_box.add_child(_label("🎊 You finished all of Foodiverse! 🎊", 20, "#A63D24"))
		_add_result_button("🎮 Bonus mini-game", "#7A5CC2", "#FFFFFF", func(): start_minigame())
		_add_result_button("🔁 Play again", "#E8D8C6", "#62483C", func(): start_level(current_level, daily_mode))
	else:
		var why := "⏰ TIME'S UP!" if reason == "time" else "💔 OUT OF LIVES!"
		result_box.add_child(_label(why + "\nDon't worry, try again!", 22, "#A63D24"))
		play_sfx("lose")
		say("Ayyo! Let's try that again, chef.")
		_add_result_button("🔁 Try again", "#E8A317", "#51392D", func(): start_level(current_level, daily_mode))

	_add_result_button("🗺️ Back to map", "#E8D8C6", "#62483C", func(): show_screen("map"))
	check_achievements()
	save_game()
	update_hud()


# ===============================================================
# MAIN LOOP
# ===============================================================
func _process(delta: float) -> void:
	if playing:
		time_left -= delta
		if time_left <= 0.0:
			time_left = 0.0
			update_timer()
			finish_level(false, "time")
		else:
			update_timer()
	if mini_running:
		_process_mini(delta)


# ===============================================================
# MINI-GAMES  (dosa flip, chop rush, stir memory)
# ===============================================================
func start_minigame() -> void:
	_clear_children(mini_box)
	mini_main_btn = null
	mini_stir_buttons.clear()
	show_screen("mini")
	var kinds := ["dosa", "chop", "stir"]
	mini_mode = kinds[randi() % kinds.size()]
	mini_running = true
	if mini_mode == "dosa":
		_mini_dosa()
	elif mini_mode == "chop":
		_mini_chop()
	else:
		_mini_stir()


func _mini_dosa() -> void:
	mini_pos = 0.0
	mini_dir = 1.0
	mini_speed = 1.0
	mini_flips = 0
	mini_hits = 0
	mini_box.add_child(_label("🫓 FLIP THE DOSA!", 30, "#A63D24"))
	mini_box.add_child(_label("Tap FLIP when the marker is in the green zone. Hit 2 of 3 flips to win!", 16))
	mini_track = Control.new()
	mini_track.custom_minimum_size = Vector2(0, 46)
	mini_track.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	mini_box.add_child(mini_track)
	var track_bg := ColorRect.new()
	track_bg.color = Color("#E8B7A8")
	track_bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	mini_track.add_child(track_bg)
	var zone := ColorRect.new()
	zone.color = Color("#7BD389")
	zone.anchor_left = 0.4
	zone.anchor_right = 0.6
	zone.anchor_top = 0.0
	zone.anchor_bottom = 1.0
	mini_track.add_child(zone)
	mini_marker = ColorRect.new()
	mini_marker.color = Color("#51392D")
	mini_marker.size = Vector2(10, 46)
	mini_track.add_child(mini_marker)
	mini_status = _label("Flips: 0 / 3     Hits: 0", 18, "#62483C")
	mini_box.add_child(mini_status)
	mini_main_btn = _button("🥞 FLIP!", "#23865B", "#FFFFFF", 72, 26)
	mini_main_btn.pressed.connect(_dosa_flip)
	mini_box.add_child(mini_main_btn)


func _dosa_flip() -> void:
	if not mini_running:
		return
	mini_flips += 1
	var frac := (mini_marker.position.x + 5.0) / maxf(mini_track.size.x, 1.0)
	var line := ""
	if frac >= 0.4 and frac <= 0.6:
		mini_hits += 1
		play_sfx("good")
		line = "✅ Perfect flip!"
	else:
		play_sfx("bad")
		line = "❌ Missed!"
	mini_speed += 0.5
	mini_status.text = "%s\nFlips: %d / 3     Hits: %d" % [line, mini_flips, mini_hits]
	if mini_flips >= 3:
		end_minigame(mini_hits >= 2)


func _mini_chop() -> void:
	mini_taps = 0
	mini_started = false
	mini_time = 5.0
	mini_box.add_child(_label("🔪 CHOP RUSH!", 30, "#A63D24"))
	mini_box.add_child(_label("Tap CHOP as fast as you can! Reach 20 chops within 5 seconds after your first tap.", 16))
	mini_status = _label("Chops: 0 / 20     ⏱️ 5.0", 20, "#62483C")
	mini_box.add_child(mini_status)
	mini_main_btn = _button("🔪 CHOP!", "#C0504D", "#FFFFFF", 90, 30)
	mini_main_btn.pressed.connect(_chop_tap)
	mini_box.add_child(mini_main_btn)


func _chop_tap() -> void:
	if not mini_running:
		return
	if not mini_started:
		mini_started = true
	mini_taps += 1
	play_sfx("pick")
	mini_status.text = "Chops: %d / 20     ⏱️ %.1f" % [mini_taps, maxf(mini_time, 0.0)]
	if mini_taps >= 20:
		end_minigame(true)


func _mini_stir() -> void:
	mini_input = 0
	var pool := ["🌶️", "🧅", "🧂", "🥄"]
	mini_seq = []
	for i in 4:
		mini_seq.append(pool[randi() % pool.size()])
	mini_box.add_child(_label("🥄 STIR THE POT!", 30, "#A63D24"))
	mini_box.add_child(_label("Memorise the order of ingredients, then tap them in the same order!", 16))
	mini_status = _label(_join(mini_seq, "  "), 34, "#51392D")
	mini_box.add_child(mini_status)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 10)
	mini_box.add_child(row)
	for e in pool:
		var b := _button(e, "#F7D9A8", "#51392D", 70, 30)
		b.disabled = true
		b.pressed.connect(_stir_press.bind(e))
		row.add_child(b)
		mini_stir_buttons.append(b)
	await get_tree().create_timer(3.0).timeout
	if not mini_running or mini_mode != "stir":
		return
	mini_status.text = "Now repeat it!  (0 / %d)" % mini_seq.size()
	mini_status.add_theme_font_size_override("font_size", 20)
	for b in mini_stir_buttons:
		if is_instance_valid(b):
			b.disabled = false


func _stir_press(e: String) -> void:
	if not mini_running:
		return
	if mini_seq[mini_input] == e:
		mini_input += 1
		play_sfx("pick")
		mini_status.text = "Good!  (%d / %d)" % [mini_input, mini_seq.size()]
		if mini_input >= mini_seq.size():
			end_minigame(true)
	else:
		end_minigame(false)


func _process_mini(delta: float) -> void:
	if mini_mode == "dosa" and is_instance_valid(mini_marker):
		mini_pos += mini_dir * mini_speed * delta
		if mini_pos >= 1.0:
			mini_pos = 1.0
			mini_dir = -1.0
		elif mini_pos <= 0.0:
			mini_pos = 0.0
			mini_dir = 1.0
		mini_marker.position.x = mini_pos * (mini_track.size.x - 10.0)
	elif mini_mode == "chop" and mini_started:
		mini_time -= delta
		mini_status.text = "Chops: %d / 20     ⏱️ %.1f" % [mini_taps, maxf(mini_time, 0.0)]
		if mini_time <= 0.0:
			end_minigame(false)


func end_minigame(won: bool) -> void:
	mini_running = false
	for b in mini_stir_buttons:
		if is_instance_valid(b):
			b.disabled = true
	if is_instance_valid(mini_main_btn):
		mini_main_btn.disabled = true
	if won:
		score += 30
		minigames_won += 1
		mini_status.text = "🎉 You won! +30 points!"
		play_sfx("win")
		confetti(30)
	else:
		mini_status.text = "😅 Not this time! Better luck next level."
		play_sfx("lose")
	save_game()
	check_achievements()
	var again := _button("🎮 Another mini-game", "#7A5CC2", "#FFFFFF", 52, 18)
	again.pressed.connect(func(): start_minigame())
	mini_box.add_child(again)
	var back := _button("🗺️ Back to map", "#E8D8C6", "#62483C", 52, 18)
	back.pressed.connect(func(): show_screen("map"))
	mini_box.add_child(back)
