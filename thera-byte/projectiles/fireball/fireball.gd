extends Projectile

@export var steer_force: float = 3.0 # Higher number = sharper turning radius
@onready var radar_zone = $RadarZone

func _physics_process(delta: float) -> void:
	# 1. Check if the radar has detected any enemies
	if radar_zone:
		var targets = radar_zone.get_overlapping_bodies()
		
		if targets.size() > 0:
			# 2. Lock onto the first enemy in the radar circle
			var target = targets[0]
			var desired_direction = (target.global_position - global_position).normalized()
			
			# 3. Smoothly curve the fireball's current direction toward the enemy
			direction = direction.lerp(desired_direction, steer_force * delta).normalized()
			
			# 4. Rotate the visual sprite so the fireball points where it is flying
			rotation = direction.angle()
			
	# 5. Call the _physics_process() from the base Projectile script 
	# to actually apply the movement math (position += direction * speed * delta)
	super(delta)
