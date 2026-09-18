extends Actor
# No need to declare gravity or speed here anymore!

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

func die() -> void:
	print("THE PLAYER HAS REACHED 0 HEALTH!")
	TransitionManager.open_menu(TransitionManager.Menu.DEATH_SCREEN)
	super() # Calls queue_free() from actor.gd
