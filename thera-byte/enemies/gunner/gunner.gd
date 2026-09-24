extends Enemy


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	

	move_and_slide()


func _on_detection_zone_body_entered(body: Node2D) -> void:
	print("player detected")
	state_machine.force_transition("RangedAttack")
	
	pass # Replace with function body.


func _on_detection_zone_body_exited(body: Node2D) -> void:
		print("player left")
		state_machine.force_transition("Idle")
