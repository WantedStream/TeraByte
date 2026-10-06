extends StaticBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_world_button_button_toggled(is_active: bool) -> void:
	if is_active:
		# Button is pressed: Open the gate
		#visible = false
		
		# set_deferred is required in Godot when disabling physics during a collision
		collision_shape.set_deferred("disabled", true)
		animated_sprite.play("opened")
	else:
		# Button is released: Close the gate
		#visible = true
		collision_shape.set_deferred("disabled", false)
		animated_sprite.play("closed")

	pass # Replace with function body.
