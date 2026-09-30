class_name StompableComponent
extends Area2D

@export var instant_kill: bool = true
@export var stomp_damage: int = 1

func _ready() -> void:
	# Listen for bodies entering the head hitbox
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	print("stompable component")

	# 1. Ensure the body has the bounce function (this confirms it is the player)
	# 2. Check if velocity.y > 0 (this guarantees the player is FALLING, not walking into them)
	if body.has_method("bounce") and body.velocity.y > 0:
		
		# Bounce the player up
		body.bounce()
		print("stompable component")
		# Apply damage or kill the parent enemy
		var enemy = get_parent()
		if instant_kill:
			enemy.queue_free() # Instantly destroy the enemy
		elif enemy.has_method("take_damage"):
			enemy.take_damage(stomp_damage) # Just deal damage instead
