extends Node

@export var initial_state: State
@export var use_animated_sprite: bool = false # Your new toggle!

var current_state: State
var states: Dictionary = {}

func _ready():
	var actor = get_parent() as Actor 
	var anim_player: Node
	
	# Grab both visual nodes safely just in case they don't exist on some enemies
	var standard_sprite = actor.get_node_or_null("Sprite2D")
	var animated_sprite = actor.get_node_or_null("AnimatedSprite2D")
	
	if use_animated_sprite:
		anim_player = animated_sprite
		# Hide the old static sprite and show the animated one
		if standard_sprite:
			standard_sprite.visible = false
		if animated_sprite:
			animated_sprite.visible = true
	else:
		anim_player = actor.get_node_or_null("AnimationPlayer")
		# Show the static sprite and hide the animated one
		if standard_sprite:
			standard_sprite.visible = true
		if animated_sprite:
			animated_sprite.visible = false
			
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.actor = actor 
			child.transition.connect(on_child_transition)
			child.animator = anim_player 
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		return
	current_state.exit()
	new_state.enter()
	current_state = new_state

func force_transition(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	
	if not new_state:
		return
		
	if current_state == new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
