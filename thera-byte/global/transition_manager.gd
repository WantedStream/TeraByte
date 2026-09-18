extends Node

# ==========================================
# 1. MENUS (Distinct States via Enum)
# ==========================================
enum Menu {
	MAIN_MENU,
	DEATH_SCREEN,
	LEVEL_COMPLETE,
	LEVEL_SELECTOR
}

const MENU_PATHS: Dictionary = {
	Menu.MAIN_MENU: "res://menus/main_menu/main_menu.tscn",
	Menu.DEATH_SCREEN: "res://menus/death_menu/death_scene.tscn",
	Menu.LEVEL_COMPLETE: "res://menus/level_complete_menu/level_complete.tscn",
	Menu.LEVEL_SELECTOR: "res://menus/level_selector/level_selector.tscn"
}

# ==========================================
# 2. LEVELS (Sequential Data via Array)
# ==========================================
const LEVEL_PATHS: Array[String] = [
	"res://levels/level_1/level_1.tscn" # Level 1 (Index 0)
	# Add "res://levels/level_2/level_2.tscn" here later!
]

# ==========================================
# TRANSITION FUNCTIONS
# ==========================================

func open_menu(menu_name: Menu) -> void:
	var path = MENU_PATHS.get(menu_name)
	if path != null:
		get_tree().call_deferred("change_scene_to_file", path)
	else:
		printerr("TransitionManager: Menu not found in dictionary!")

func get_total_levels() -> int:
	return LEVEL_PATHS.size()

func load_level(level_number: int) -> void:
	var index = level_number - 1 # Arrays start at 0
	
	if index >= 0 and index < LEVEL_PATHS.size():
		get_tree().call_deferred("change_scene_to_file", LEVEL_PATHS[index])
	else:
		printerr("TransitionManager: Level ", level_number, " does not exist in LEVEL_PATHS!")
