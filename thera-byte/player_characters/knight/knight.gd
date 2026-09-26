extends BasePlayer


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
	#apply_gravity(delta)
	
	#move_and_slide()
	pass

func _on_melee_hitbox_body_entered(body: Node2D) -> void:
		body.take_damage(1)
