extends State

func enter():
	animator.play("idle")
#	EventBus.test_signal_fired.emit("Hello from the Idle state!")
	
func physics_update(delta):
	# 1. Handle Physics (Friction and Gravity)
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	player.velocity.x = move_toward(player.velocity.x, 0, player.speed * delta * 10)
	player.move_and_slide()
	
	# 2. Handle Independent Transitions
	if not player.is_on_floor():
		transition.emit(self, "fall")
	elif Input.is_action_just_pressed("up"): # Replace "up" with your jump input
		transition.emit(self, "jump")
	elif Input.get_vector("left", "right", "up", "down").x != 0:
		transition.emit(self, "run")
