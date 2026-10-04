extends StaticBody2D

@export var item_scene: PackedScene # Drag your coin.tscn into this slot in the Inspector
@export var bump_height: float = -12.0
@export var bump_duration: float = 0.1

var is_active: bool = true
@onready var start_y: float = position.y
@onready var sprite = $Sprite2D

func _ready() -> void:
	$BottomSensor.body_entered.connect(_on_bottom_sensor_body_entered)

func _on_bottom_sensor_body_entered(body: Node2D) -> void:
	# 1. Ensure the block hasn't been hit yet
	# 2. Ensure it is the player. 
	# (Note: This requires 'class_name BasePlayer' at the top of your base_player.gd script. 
	# If you don't have that, you can change it to: if is_active and body.name == "Knight":)
	if is_active and body is BasePlayer:
		trigger_block()
		
		# Bounce the player back down slightly so they don't hover against the ceiling
		body.velocity.y = 100 

func trigger_block() -> void:
	is_active = false
	
	# Spawn the item
	if item_scene:
		var item = item_scene.instantiate()
		get_tree().current_scene.call_deferred("add_child", item)
		# Spawn the item exactly one tile above the block (assuming 64x64 tiles)
		item.global_position = global_position + Vector2(0, -64) 
		
	animate_bump()
	sprite.frame = 1
	# Optional: Change the sprite to the "empty" metal block visual
	# sprite.texture = load("res://path_to_empty_block.png") 
	# OR if using a sprite sheet: sprite.frame = 1 

func animate_bump() -> void:
	var tween = create_tween()
	# Move the block up quickly
	tween.tween_property(self, "position:y", start_y + bump_height, bump_duration)
	# Move the block back down to its original starting height
	tween.tween_property(self, "position:y", start_y, bump_duration)
