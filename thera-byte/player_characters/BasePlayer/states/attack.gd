extends State
class_name BaseAttackState

func enter() -> void:
	# 1. Stop horizontal movement
	actor.velocity.x = 0
	
	# 2. Start the animation
	animator.play("attack")
	
	# 3. Connect the signal to track frames
	if animator is AnimatedSprite2D:
		if not animator.frame_changed.is_connected(_on_frame_changed):
			animator.frame_changed.connect(_on_frame_changed)
	
	# 4. Wait for the animation to finish
	await animator.animation_finished
	transition.emit(self, "Idle")
	

func exit() -> void:
	# Clean up the signal
	if animator is AnimatedSprite2D:
		if animator.frame_changed.is_connected(_on_frame_changed):
			animator.frame_changed.disconnect(_on_frame_changed)

func _on_frame_changed() -> void:
	# Frame 1 is the action frame (sword swing or arrow release)
	if animator.frame == 1:
		execute_attack()
		print("executed attack")

# This is a "virtual" function. The base player does nothing here,
# but the Knight and Archer will overwrite it with their own logic!
func execute_attack() -> void:
	pass
