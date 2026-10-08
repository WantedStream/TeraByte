class_name Enemy
extends Actor

@export var contact_damage: int = 1
var target: Node2D = null # Add this line!
func _ready() -> void:
	super() # Grabs the starting health from Actor

# Universal logic: Every single enemy hurts the player on contact.
func _on_hitbox_body_entered(body: Node2D) -> void:
	#if body.name == "CharacterBody2D":
	EventBus.player_damaged.emit(contact_damage)
