extends State

var shooter: ShooterComponent
@export var animation_name: String = ""
@export var fire_rate: float = 1.0 # How many seconds between each shot

var time_since_last_shot: float = 0.0

func enter():
	shooter = actor.get_node_or_null("ShooterComponent")
	# Set this to fire_rate so the enemy shoots instantly the moment the player enters
	time_since_last_shot = fire_rate 

func physics_update(delta: float):
	# 1. Constantly count up using delta (the time between frames)
	time_since_last_shot += delta
	
	# 2. When enough time has passed, fire a bullet and reset the clock
	if time_since_last_shot >= fire_rate:
		time_since_last_shot = 0.0
		_aim_and_shoot()

# The actual math for aiming and shooting
func _aim_and_shoot():
	animator.play(animation_name)
	var detection_zone = actor.get_node_or_null("DetectionZone")
	
	if shooter and detection_zone:
		var targets = detection_zone.get_overlapping_bodies()
		
		if targets.size() > 0:
			var player = targets[0] 
			
			# Calculate angle and flip sprite
			var direction = (player.global_position - actor.global_position).normalized()
			var sprite = actor.get_node_or_null("Sprite2D")
			if sprite:
				sprite.flip_h = (direction.x > 0)
			
			# Fire!
			shooter.fire_projectile(direction)
