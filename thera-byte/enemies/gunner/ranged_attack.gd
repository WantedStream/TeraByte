extends State

@export var animation_name: String = ""
@export var fire_rate: float = 1.0
@export var component_name: String = "ShooterComponent" # Tell the inspector which node to look for

var time_since_last_shot: float = 0.0

func enter():
	time_since_last_shot = fire_rate 

func physics_update(delta: float):
	time_since_last_shot += delta
	if time_since_last_shot >= fire_rate:
		time_since_last_shot = 0.0
		_aim_and_attack()

func _aim_and_attack():
	animator.play(animation_name)
	
	# Grab the generic component based on what you typed in the Inspector
	var action_node = actor.get_node_or_null(component_name)
	var detection_zone = actor.get_node_or_null("DetectionZone")
	
	if action_node and detection_zone:
		var targets = detection_zone.get_overlapping_bodies()
		if targets.size() > 0:
			var player = targets[0] 
			var direction = (player.global_position - actor.global_position).normalized()
			
			var sprite = actor.get_node_or_null("Sprite2D")
			if sprite:
				sprite.flip_h = (direction.x > 0)
			
			# The state doesn't care if it's a gun or a sword. 
			# It just hits the universal execute button.
			if action_node.has_method("execute_action"):
				action_node.execute_action(direction)
