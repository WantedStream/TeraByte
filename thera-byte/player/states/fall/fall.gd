extends State
func enter():
	animator.play("fall")
func physics_update(delta):
	# 1. Apply continuous gravity
	player.velocity.y += player.gravity * delta
	
	# 2. Allow horizontal air movement
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity.x = direction.x * player.speed
	
	player.move_and_slide()
	
	# 3. Handle Transitions
	if player.is_on_floor():
		if direction.x == 0:
			transition.emit(self, "idle") # Landed standing still
		else:
			transition.emit(self, "run")  # Landed while running
