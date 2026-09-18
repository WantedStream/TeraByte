extends State

func enter():
	animator.play("run")
	
func physics_update(delta):
	# 1. Apply gravity (just in case we step off a ledge this frame)
	actor.apply_gravity(delta)
		
	# 2. Handle Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	actor.velocity.x = direction.x * actor.speed
	
	actor.move_and_slide()
	
	# 3. Handle Transitions
	if not actor.is_on_floor():
		transition.emit(self, "fall") # Walked off a ledge
	elif Input.is_action_just_pressed("up"): 
		transition.emit(self, "jump") # Jumped
	elif direction.x == 0:
		transition.emit(self, "idle") # Stopped pressing left/right
