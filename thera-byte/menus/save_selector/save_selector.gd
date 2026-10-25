extends Control

@onready var slots = [
	$VBoxContainer/Slot1,
	$VBoxContainer/Slot2,
	$VBoxContainer/Slot3
]

func _ready() -> void:
	refresh_ui()

func refresh_ui() -> void:
	for i in range(3):
		var slot_number = i + 1
		var ui_row = slots[i]
		
		var info_label = ui_row.get_node("InfoLabel")
		var load_btn = ui_row.get_node("LoadButton")
		var delete_btn = ui_row.get_node("DeleteButton")
		
		# Disconnect signals to prevent double-firing when refreshing the UI
		if load_btn.pressed.is_connected(_on_load_pressed):
			load_btn.pressed.disconnect(_on_load_pressed)
		if delete_btn.pressed.is_connected(_on_delete_pressed):
			delete_btn.pressed.disconnect(_on_delete_pressed)
			
		# Check the file on the hard drive
		var save_data = SaveManager.preview_save(slot_number)
		
		if save_data.is_empty():
			info_label.text = "Slot " + str(slot_number) + " - Empty"
			load_btn.text = "New Game"
			delete_btn.disabled = true
		else:
			info_label.text = "Slot " + str(slot_number) + " - Coins: " + str(save_data.get("coins", 0))
			load_btn.text = "Play"
			delete_btn.disabled = false
			
		# Connect the buttons and pass the slot_number to the functions
		load_btn.pressed.connect(_on_load_pressed.bind(slot_number))
		delete_btn.pressed.connect(_on_delete_pressed.bind(slot_number))

func _on_load_pressed(slot_number: int) -> void:
	SaveManager.load_game(slot_number)
	get_tree().change_scene_to_file("res://menus/level_selector/level_selector.tscn")

func _on_delete_pressed(slot_number: int) -> void:
	SaveManager.delete_save(slot_number)
	refresh_ui() # Instantly update the text to "Empty"
