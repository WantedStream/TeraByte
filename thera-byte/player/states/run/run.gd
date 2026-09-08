extends State
func enter():
	animator.play("run")
	
func physics_update(delta):
	# 1. Apply gravity (just in case we step off a ledge this frame)
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
		
	# 2. Handle Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity.x = direction.x * player.speed
	
	player.move_and_slide()
	
	# 3. Handle Transitions
	if not player.is_on_floor():
		transition.emit(self, "fall") # Walked off a ledge
	elif Input.is_action_just_pressed("up"): 
		transition.emit(self, "jump") # Jumped
	elif direction.x == 0:
		transition.emit(self, "idle") # Stopped pressing left/right
