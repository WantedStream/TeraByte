class_name BasePlayer

extends Actor
# No need to declare gravity or speed here anymore!
@onready var sprite = $Sprite2D # Make sure this matches your Sprite node name
const BOUNCE_VELOCITY = -400.0 # Adjust this to make the bounce higher/lower

func _ready() -> void:
	print("The script is attached and alive!")
	current_health = max_health
	EventBus.health_changed.emit(current_health)
	EventBus.player_damaged.connect(take_damage)

func take_damage(amount: int) -> void:
	# 'super' calls the take_damage function inside actor.gd to handle the math
	super(amount) 
	
	# Then we update the UI, because only the Player has a UI
	EventBus.health_changed.emit(current_health)	

# Inside base_player.gd

func bounce() -> void:
	velocity.y = BOUNCE_VELOCITY
	$StateMachine.force_transition("Jump")
	
func die() -> void:
	print("THE PLAYER HAS REACHED 0 HEALTH!")
	TransitionManager.open_menu(TransitionManager.Menu.DEATH_SCREEN)
	super() # Calls queue_free() from actor.gd
func _unhandled_input(event: InputEvent) -> void:
	# When the player presses the attack button
	if event.is_action_pressed("attack"): 
		# Command the state machine to switch to the Attack state immediately
		state_machine.force_transition("Attack")


# This function flips the image based on input direction
func face_direction(direction: float) -> void:
	if direction > 0:
		sprite.flip_h = false # Face right
	elif direction < 0:
		sprite.flip_h = true  # Face left
