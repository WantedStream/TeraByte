extends Area2D

signal button_toggled(is_active: bool)

enum ButtonBehavior { MOMENTARY, TOGGLE, ONE_SHOT }
@export var behavior: ButtonBehavior = ButtonBehavior.MOMENTARY

var is_pressed: bool = false

# Grab reference to the new AnimatedSprite2D node
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	update_visuals()

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"): 
		return
		
	if behavior == ButtonBehavior.ONE_SHOT and is_pressed:
		return 
		
	if behavior == ButtonBehavior.TOGGLE:
		is_pressed = !is_pressed 
	else:
		is_pressed = true 
		
	execute_press()

func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("player"): 
		return
		
	if behavior == ButtonBehavior.MOMENTARY:
		is_pressed = false
		execute_press()

func execute_press() -> void:
	update_visuals()
	
	if audio != null:
		audio.play()
		
	button_toggled.emit(is_pressed)

func update_visuals() -> void:
	if animated_sprite == null:
		return
		
	# Play the specific animations based on the button's state
	if is_pressed:
		animated_sprite.play("pressed")
	else:
		animated_sprite.play("unpressed")
