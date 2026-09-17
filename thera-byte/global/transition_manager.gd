extends Node

enum Scene {
	MAIN_MENU,
	DEATH_SCREEN,
	LEVEL_COMPLETE,
	LEVEL_SELECTOR,
	LEVEL_1
}

const SCENE_PATHS: Dictionary = {
	Scene.MAIN_MENU: "res://menus/main_menu/main_menu.tscn",
	Scene.DEATH_SCREEN: "res://menus/death_menu/death_scene.tscn",
	Scene.LEVEL_COMPLETE: "res://menus/level_complete_menu/level_complete.tscn",
	Scene.LEVEL_SELECTOR: "res://level_selector/level_selector.tscn",
	Scene.LEVEL_1: "res://levels/level_1/level_1.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func transition_to(scene_name: Scene) -> void:
		var path = SCENE_PATHS.get(scene_name)
		if path != null:
			get_tree().call_deferred("change_scene_to_file", path)
		else:
			printerr("TransitionManager: Attempted to load a scene that is not in the dictionary!")
