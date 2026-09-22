extends State

var shooter: ShooterComponent
@export var animation_name: String = ""

func enter():
	animator.play(animation_name) # Make sure your animation is exactly named "shoot"
	shooter = actor.get_node_or_null("ShooterComponent")
	var detection_zone = actor.get_node_or_null("DetectionZone")
	
	if shooter and detection_zone:
		# 1. Grab all bodies currently inside the Area2D
		var targets = detection_zone.get_overlapping_bodies()
		
		if targets.size() > 0:
			var player = targets[0] # Mask 2 guarantees this is the player
			
			# 2. Calculate the direction from the enemy to the player
			var direction = (player.global_position - actor.global_position).normalized()
			
			# 3. Optional: Flip the enemy sprite to face the player while shooting
			var sprite = actor.get_node_or_null("Sprite2D")
			if sprite:
				sprite.flip_h = (direction.x > 0)
			
			# 4. Fire the bullet in the calculated direction
			shooter.fire_projectile(direction)
		
	# Ensure the animation actually tells this script when it's done
	if not animator.animation_finished.is_connected(_on_animation_finished):
		animator.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: String):
	if anim_name == animation_name:
		var detection_zone = actor.get_node_or_null("DetectionZone")
		
		# 1. Evaluate: Is the player still inside the zone?
		if detection_zone and detection_zone.has_overlapping_bodies():
			# They are still here. Restart this state to fire again.
			enter() 
		else:
			# They left the zone. Safe to resume patrol.
			transition.emit(self, "patrol")
