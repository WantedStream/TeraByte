class_name Enemy
extends Actor

@export var contact_damage: int = 1

func _ready() -> void:
	super() # Grabs the starting health from Actor

# Universal logic: Every single enemy hurts the player on contact.
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		EventBus.player_damaged.emit(contact_damage)
