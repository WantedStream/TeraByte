extends State

@export var patrol_speed: float = 100.0
var direction: float = -1.0 # -1 is left, 1 is right

func enter():
	if animator.has_animation("walk"):
		animator.play("walk")

func physics_update(delta):
	# 1. Inherit gravity from the Actor class
	actor.apply_gravity(delta)

	# 2. Apply horizontal AI movement
	actor.velocity.x = direction * patrol_speed
	actor.move_and_slide()

	# 3. Flip direction if it walks into a wall
	if actor.is_on_wall():
		direction *= -1.0

		# Optional: Flip the visual sprite
		var sprite = actor.get_node("Sprite2D") # Adjust name if you used ColorRect
		if sprite:
			sprite.flip_h = (direction == 1.0)
