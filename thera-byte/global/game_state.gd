extends Node

# The live memory of your game
var data: Dictionary = {
	"levels_completed": [], 
	"coins": 0, 
	"selected_character": "knight"
}

# --- GAMEPLAY HELPER FUNCTIONS ---

func add_coins(amount: int = 1) -> void:
	data["coins"] += amount
	SaveManager.save_game() # Tell the SaveManager to write the file
	print("Coins updated: ", data["coins"])

func mark_level_completed(level_number: int) -> void:
	var completed: Array = data.get("levels_completed", [])
	
	if not level_number in completed:
		completed.append(level_number)
		data["levels_completed"] = completed
		SaveManager.save_game()
		print("Level ", level_number, " completed and saved!")
		
# Add future functions here, like unlock_character(), add_death(), etc.
