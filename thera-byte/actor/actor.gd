class_name Actor
extends CharacterBody2D
@export var jump_velocity: float = -400.0
# --- Universal Physics Constants ---
const gravity: float = 980.0
@export var speed: float = 400.0 # ADD THIS
# --- Universal Stats ---
@export var max_health: int = 3
var current_health: int
@onready var state_machine = $StateMachine

func _ready() -> void:
	current_health = max_health

# Every single character falls, so we write the math exactly once here.
func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

# Universal health logic for players, NPCs, and bosses.
func take_damage(amount: int) -> void:
	current_health -= amount
	print(name, " took damage! Current health: ", current_health)
	
	if current_health <= 0:
		die()

func die() -> void:
	print(name, " has died.")
	queue_free()
