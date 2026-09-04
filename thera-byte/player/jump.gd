extends State

func enter():
	player.velocity.y = -400.0 # Set your jump velocity here

func physics_update(delta):
	player.velocity.y += player.gravity * delta
	
	# Allow horizontal movement in the air
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity.x = direction.x * player.speed
	
	player.move_and_slide()
	
	# Once we start falling downward, switch to fall state
	if player.velocity.y > 0:
		transition.emit(self, "fall")
