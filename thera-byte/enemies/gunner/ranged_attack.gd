extends State

var shooter: ShooterComponent
@export var animation_name: String = ""

func enter():
	animator.play(animation_name) # Make sure your animation is exactly named "shoot"
	shooter = actor.get_node_or_null("RangedAttack")
	
	if shooter:
		shooter.fire_projectile(Vector2.LEFT)
		
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
