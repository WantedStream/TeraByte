extends State

var hitbox: CollisionShape2D

func enter() -> void:
	# 1. Stop horizontal movement
	actor.velocity.x = 0
	
	# 2. Grab the actual CollisionShape2D node inside your MeleeHitbox
	hitbox = actor.get_node_or_null("MeleeHitbox/CollisionShape2D")
	
	# 3. Start the animation
	animator.play("attack")
	print("attack state")
	
	# 4. If using AnimatedSprite2D, connect the signal to track frames
	if animator is AnimatedSprite2D:
		if not animator.frame_changed.is_connected(_on_frame_changed):
			animator.frame_changed.connect(_on_frame_changed)
	
	# 5. Wait for the animation to finish
	await animator.animation_finished
	
	print("idle state")
	transition.emit(self, "Idle")

func exit() -> void:
	# Clean up the signal so it doesn't fire when running or jumping
	if animator is AnimatedSprite2D:
		if animator.frame_changed.is_connected(_on_frame_changed):
			animator.frame_changed.disconnect(_on_frame_changed)
			
	# CRITICAL: Always turn the hitbox off when leaving the attack state!
	if hitbox:
		hitbox.set_deferred("disabled", true)

func _on_frame_changed() -> void:
	# Safety check
	if not hitbox:
		return
		
	# Frame 1 is the second image of your 2-frame animation
	if animator.frame == 1:
		hitbox.set_deferred("disabled", false)
