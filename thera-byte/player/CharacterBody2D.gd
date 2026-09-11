extends CharacterBody2D

@export var speed: float = 300.0
@export var gravity: float = 300.0
@export var health = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("The script is attached and alive!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

#func _physics_process(delta):
		#var direction=Input.get_vector("left","right","up","down")
		#velocity.x=direction.x*speed
		#velocity.y += gravity* delta
		#print("Current Velocity: ", velocity)
		#move_and_slide()
		
