class_name Crate
extends CharacterBody2D

@export var push_speed: float = 80.0
@export var friction: float = 800.0

var pusher: Node2D = null

func _ready() -> void:
	# Lets the crate hold down your WorldButton
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# 1. Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# 2. If the player is touching the side, push away from the player's X position
	if pusher != null:
		var push_direction: float = sign(global_position.x - pusher.global_position.x)
		velocity.x = push_direction * push_speed
	else:
		# Stop immediately when the player stops pushing
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
	move_and_slide()

func _on_push_zone_body_entered(body: Node2D) -> void:
	# Collision mask guarantees this is the player
	pusher = body

func _on_push_zone_body_exited(body: Node2D) -> void:
	if body == pusher:
		pusher = null
