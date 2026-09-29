extends BasePlayer


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
@onready var melee_hitbox = $MeleeHitbox # Make sure this matches your hitbox node name

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
	#apply_gravity(delta)
	
	#move_and_slide()
	pass

func _on_melee_hitbox_body_entered(body: Node2D) -> void:
		body.take_damage(1)

func face_direction(direction: float) -> void:
	# 1. Flip the sprite (calls the function from base_player.gd)
	super(direction) 
	
	# 2. Flip the hitbox
	if direction > 0:
		# Face Right: Force X position to be positive
		melee_hitbox.position.x = abs(melee_hitbox.position.x)
		melee_hitbox.scale.x = 1
	elif direction < 0:
		# Face Left: Force X position to be negative
		melee_hitbox.position.x = -abs(melee_hitbox.position.x)
		melee_hitbox.scale.x = -1


func _on_melee_hitbox_area_entered(area: Area2D) -> void:
	if area is Projectile:
		area.queue_free()
	print("area entered")
	pass # Replace with function body.
