extends CharacterBody2D

@export var speed: float = 400.0
@export var gravity: float = 300.0

@export var max_health: int = 3
var current_health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("The script is attached and alive!")
	
	current_health = max_health
	
	# 2. Wire the interrupt to the Event Bus
	EventBus.player_damaged.connect(take_damage)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	
func take_damage(amount: int):
	# Subtract the damage
	current_health -= amount
	
	# Let's print it to prove the math works
	print("Ouch! Took ", amount, " damage. Health is now: ", current_health)
	Values.health=current_health
	# Check if the player should be dead
	if current_health <= 0:
		current_health = 0 # Prevent negative numbers
		die()
func level_complete():
	print("level_completed")
func die():
	print("THE PLAYER HAS REACHED 0 HEALTH!")
	#get_tree().call_deferred("reload_current_scene")
	TransitionManager.transition_to(TransitionManager.Scene.DEATH_SCREEN)
	# We will build the actual death logic (like switching to a Death state) later.
#func _physics_process(delta):
		#var direction=Input.get_vector("left","right","up","down")
		#velocity.x=direction.x*speed
		#velocity.y += gravity* delta
		#print("Current Velocity: ", velocity)
		#move_and_slide()
		
