extends Area2D

@export var level_id: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		EventBus.finish_level.emit(level_id)
		print("entered door")
	pass # Replace with function body.
