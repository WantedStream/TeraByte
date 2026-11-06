extends Area2D

@export var level_id: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_body_entered(body: Node2D) -> void:
	GameState.mark_level_completed(level_id)
		
		# 2. Trigger the UI menu transition
	TransitionManager.open_menu(TransitionManager.Menu.LEVEL_COMPLETE)
	pass # Replace with function body.
