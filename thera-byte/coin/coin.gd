extends Area2D

@export var coin_value: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		EventBus.coin_collected.emit(coin_value)
		queue_free() #deletes from game
	pass # Replace with function body.
