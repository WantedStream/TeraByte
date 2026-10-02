extends Node2D

# Allows each level (1, 2, 3...) to set its own ID and target scene in the Inspector
@export var level_id: int = 1
@export_file("*.tscn") var next_level_scene: String

@onready var spawn_point = $PlayerSpawnPoint

func _ready() -> void:
	# 1. Spawn player at the designated marker
	if Values.selected_character and spawn_point:
		var player_instance = Values.selected_character.instantiate()
		add_child(player_instance)
		player_instance.global_position = spawn_point.global_position
		
	# 2. Connect global signals
	EventBus.coin_collected.connect(on_coin_collected)
	EventBus.finish_level.connect(on_door_collide)
	EventBus.test_signal_fired.connect(on_test_signal)

func on_door_collide(finished_id):
	# Confirm the door triggered corresponds to this level
	print("Level completed: ", finished_id)
	TransitionManager.open_menu(TransitionManager.Menu.LEVEL_COMPLETE)

func on_coin_collected(value: int) -> void:
	print("Level registered coin value: ", value)

func on_test_signal(message: String) -> void:
	print("Main level received test signal: ", message)
