extends Control

@export var knight_scene: PackedScene
@export var archer_scene: PackedScene
@export var magician_scene: PackedScene
@export var tank_scene: PackedScene

# 1. Grab references using the exact paths from your scene tree
@onready var knight_btn = $HBoxContainer/KnightSelection/KnightButton
@onready var archer_btn = $HBoxContainer/ArcherSelection/ArcherButton
@onready var magician_btn = $HBoxContainer/MagicianSelection/MagicianButton
@onready var tank_btn = $HBoxContainer/TankSelection/TankButton

# Group them into an array to easily loop through them
@onready var all_buttons = [knight_btn, archer_btn, magician_btn, tank_btn]

func _ready() -> void:
	# 2. Set the Knight as the default selection when the menu opens
	Values.selected_character = knight_scene
	update_button_visuals(knight_btn)

# 3. Helper function that turns off all buttons, then turns on the clicked one
func update_button_visuals(active_button: Button) -> void:
	for btn in all_buttons:
		if btn == active_button:
			# Light up the selected button (Change Color.GREEN to whatever you prefer)
			btn.modulate = Color.GREEN
		else:
			# Reset the unselected buttons to standard white (default)
			btn.modulate = Color.WHITE

func _on_knight_button_pressed() -> void:
	Values.selected_character = knight_scene
	update_button_visuals(knight_btn)

func _on_archer_button_pressed() -> void:
	Values.selected_character = archer_scene
	update_button_visuals(archer_btn)

func _on_magician_button_pressed() -> void:
	Values.selected_character = magician_scene
	update_button_visuals(magician_btn)

func _on_tank_button_pressed() -> void:
	Values.selected_character = tank_scene
	update_button_visuals(tank_btn)

func _on_main_menu_button_pressed() -> void:
	TransitionManager.open_menu(TransitionManager.Menu.MAIN_MENU)
