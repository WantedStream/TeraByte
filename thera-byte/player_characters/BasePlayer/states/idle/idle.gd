extends State

func enter():
	animator.play("idle")
	
func physics_update(delta):
	actor.apply_gravity(delta) # One clean line handles gravity!
	
	actor.velocity.x = move_toward(actor.velocity.x, 0, actor.speed * delta * 10)
	actor.move_and_slide()
	
	if not actor.is_on_floor():
		transition.emit(self, "fall")
	elif Input.is_action_just_pressed("up"): 
		transition.emit(self, "jump")
	elif Input.get_vector("left", "right", "up", "down").x != 0:
		transition.emit(self, "run")
