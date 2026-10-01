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
	
	flash_red()
	
	if current_health <= 0:
		die()
	
func flash_red() -> void:
	# 1. Safely check for the AnimatedSprite2D first
	var sprite = get_node_or_null("AnimatedSprite2D")
	
	# 2. If it is null (doesn't exist), assign the standard Sprite2D instead
	if sprite == null:
		sprite = get_node_or_null("Sprite2D")
		
	# 3. Safety check: If BOTH are missing, exit the function so the game doesn't crash
	if sprite == null:
		return
	# Instantly turn the sprite completely red
	sprite.modulate = Color.RED
	
	# Create a Tween to smoothly fade it back to its normal color (White) over 1.0 second
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.WHITE, 1.0)

func die() -> void:
	print(name, " has died.")
	queue_free()
