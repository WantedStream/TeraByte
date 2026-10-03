extends BaseAttackState

@export var charge_speed: float = 600.0 # Adjust this to make the dash faster/slower
var charge_direction: float = 1.0
var hitbox: CollisionShape2D

func enter() -> void:
	# 1. Grab the Tank's specific hitbox
	hitbox = actor.get_node_or_null("MeleeHitbox/CollisionShape2D")
	
	# 2. Figure out which way the Tank is facing
	var sprite = actor.get_node_or_null("AnimatedSprite2D")
	if not sprite:
		sprite = actor.get_node_or_null("Sprite2D")
		
	if sprite and sprite.flip_h:
		charge_direction = -1.0
	else:
		charge_direction = 1.0
		
	# 3. CRITICAL: Do NOT stop movement. Blast forward!
	actor.velocity.x = charge_speed * charge_direction
	
	# 4. Turn on the damage hitbox instantly
	if hitbox:
		hitbox.set_deferred("disabled", false)
		
	# 5. Play the animation
	animator.play("attack")
	
	# 6. Wait for the dash animation to finish
	await animator.animation_finished
	
	transition.emit(self, "Idle")

func exit() -> void:
	# Turn off the hitbox when the charge is over
	if hitbox:
		hitbox.set_deferred("disabled", true)
		
# Optional: If you find the Tank slowing down too quickly due to floor friction
# before the animation finishes, uncomment the line below to lock their speed.
# func _physics_process(delta: float) -> void:
# 	actor.velocity.x = charge_speed * charge_direction
