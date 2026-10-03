class_name Projectile
extends Area2D

@export var speed: float = 500.0
@export var damage: int = 1

var direction: Vector2 = Vector2.ZERO

func _ready():
	# Make sure the Area2D only looks for the Player layer (e.g., Mask 2)
	body_entered.connect(_on_body_entered)
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)

# The ShooterComponent calls this exactly once when spawning the bullet
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
	# Optional: Rotate the bullet to face the way it's flying
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	# Move the projectile purely using math, ignoring world friction
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	# Check if the body we hit has the universal damage function
	if body.has_method("take_damage"):
		body.take_damage(damage)
		
	# Destroy the bullet regardless of what it hit (e.g., hitting a wall)
	queue_free()
func _on_screen_exited() -> void:
	# Delete the bullet if it misses and flies off the screen
	queue_free()
