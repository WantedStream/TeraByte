extends State

func enter():
	animator.play("fall")

func physics_update(delta):
	# 1. Apply continuous gravity using our new Actor class!
	actor.apply_gravity(delta)
	
	# 2. Allow horizontal air movement
	var direction = Input.get_vector("left", "right", "up", "down")
	actor.velocity.x = direction.x * actor.speed
	
	actor.move_and_slide()
	
	# 3. Handle Transitions
	if actor.is_on_floor():
		if direction.x == 0:
			transition.emit(self, "idle") # Landed standing still
		else:
			transition.emit(self, "run")  # Landed while running
