extends BaseAttackState

@export var component_name: String = "ShooterComponent"
var shooter_component: Node

func enter() -> void:
	# Grab the ShooterComponent from the Archer's tree
	shooter_component = actor.get_node_or_null(component_name)
	
	# Call super() to run the animation and movement lock from base_attack.gd
	super() 

# Overwrite the empty execute_attack function from base_attack.gd
func execute_attack() -> void:
	if not shooter_component:
		return
		
	# 1. Determine which way the Archer is facing
	var sprite = actor.get_node_or_null("AnimatedSprite2D")
	if not sprite:
		sprite = actor.get_node_or_null("Sprite2D")
		
	var shoot_direction = Vector2.RIGHT
	if sprite and sprite.flip_h:
		shoot_direction = Vector2.LEFT
		
	# 2. Move the spawn point to the correct side of the player
	var spawn_point = shooter_component.get_node_or_null("Marker2D")
	if spawn_point:
		spawn_point.position.x = abs(spawn_point.position.x) * shoot_direction.x
		
	# 3. Pull the trigger on the ShooterComponent
	if shooter_component.has_method("execute_action"):
		shooter_component.execute_action(shoot_direction)
