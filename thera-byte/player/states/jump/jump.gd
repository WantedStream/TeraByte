extends State

func enter():
	animator.play("jump")
	actor.velocity.y = -400.0 # Set your jump velocity here

func physics_update(delta):
	actor.apply_gravity(delta)
	
	# Allow horizontal movement in the air
	var direction = Input.get_vector("left", "right", "up", "down")
	actor.velocity.x = direction.x * actor.speed
	
	actor.move_and_slide()
	
	# Once we start falling downward, switch to fall state
	if actor.velocity.y > 0:
		transition.emit(self, "fall")
