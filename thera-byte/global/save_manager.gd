extends Node

var current_slot: int = 1
var game_data: Dictionary = {
	"levels_completed": [], 
	"coins": 0, 
	"selected_character": "knight"
}

func get_save_path(slot: int) -> String:
	return "user://savegame_" + str(slot) + ".json"

func save_game() -> void:
	var file = FileAccess.open(get_save_path(current_slot), FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(game_data, "\t"))
		file.close()
		print("Saved data to slot ", current_slot)

func load_game(slot: int) -> void:
	current_slot = slot
	var path = get_save_path(slot)
	
	if FileAccess.file_exists(path):
		var json_string = FileAccess.get_file_as_string(path)
		var parsed_data = JSON.parse_string(json_string)
		if parsed_data is Dictionary:
			game_data = parsed_data
			print("Loaded slot ", current_slot, ": ", game_data)
	else:
		# Reset to defaults if the slot is empty
		game_data = {"current_level": "res://base_level.tscn", "coins": 0, "selected_character": "knight"}
		print("No save found in slot ", current_slot, ". Created new defaults.")

func delete_save(slot: int) -> void:
	var path = get_save_path(slot)
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)
		print("Deleted save in slot ", slot)

# This will be used later by your UI to read data without overwriting the active game
func preview_save(slot: int) -> Dictionary:
	var path = get_save_path(slot)
	if FileAccess.file_exists(path):
		var json_string = FileAccess.get_file_as_string(path)
		var parsed_data = JSON.parse_string(json_string)
		if parsed_data is Dictionary:
			return parsed_data
	return {}
