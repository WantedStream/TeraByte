extends BaseAttackState

var hitbox: CollisionShape2D

func enter() -> void:
	# Grab the specific knight hitbox
	hitbox = actor.get_node_or_null("MeleeHitbox/CollisionShape2D")
	
	# Call the enter() function from BaseAttackState to handle movement and animation
	super() 

func exit() -> void:
	# Call the exit() function from BaseAttackState to disconnect signals
	super()
	
	# Knight-specific cleanup
	if hitbox:
		hitbox.set_deferred("disabled", true)

# Overwrite the empty base function with the Knight's melee logic
func execute_attack() -> void:
	if hitbox:
		hitbox.set_deferred("disabled", false)
