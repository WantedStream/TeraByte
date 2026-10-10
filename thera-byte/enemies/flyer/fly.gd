extends State 

@export var fly_speed: float = 80.0

func enter() -> void:
	if animator != null:
		if animator is AnimationPlayer:
			animator.play("fly")
		elif animator is AnimatedSprite2D:
			animator.play("fly")

func exit() -> void:
	actor.velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	# Safety check: If target is lost, stop flying
	if actor.target == null:
		transition.emit(self, "idle")
		return
		
	# 1. Calculate direction to the detected target
	var direction = actor.global_position.direction_to(actor.target.global_position)
	
	# 2. Apply velocity directly toward the target
	actor.velocity = direction * fly_speed
	actor.move_and_slide()
	
	# 3. Flip the sprite based on movement
	_flip_visuals(actor.velocity.x)


func _flip_visuals(move_x: float) -> void:
	if move_x == 0:
		return
		
	var sprite = actor.get_node_or_null("Sprite2D")
	if sprite == null:
		sprite = actor.get_node_or_null("AnimatedSprite2D")
		
	if sprite != null:
		sprite.flip_h = move_x < 0
