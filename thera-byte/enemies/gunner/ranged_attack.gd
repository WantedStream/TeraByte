extends State

var shooter: ShooterComponent

func enter():
	animator.play("shoot")
	# Find the component on the specific actor
	shooter = actor.get_node_or_null("ShooterComponent")
	
	if shooter:
		# Ask the component to do the heavy lifting
		shooter.fire_projectile(Vector2.LEFT)

func _on_animation_finished(anim_name):
	if anim_name == "shoot":
		transition.emit(self, "patrol")
