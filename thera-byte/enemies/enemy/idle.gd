extends State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


@export var animation_name: String = ""
var direction: float = -1.0 # -1 is left, 1 is right

func enter():
	if animator.has_animation(animation_name):
		animator.play(animation_name)
		
		actor.velocity.x = 0.0
func physics_update(delta):
	# 1. Inherit gravity from the Actor class
	actor.apply_gravity(delta)

	# 2. Apply movement
	actor.move_and_slide()
