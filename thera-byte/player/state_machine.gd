extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready():
	var actor = get_parent() as Actor # Grabs the Actor!
	var anim_player = actor.get_node("AnimationPlayer")
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.actor = actor # Pass the actor to the state
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
	# This allows the root character script to aggressively interrupt the current state
func force_transition(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	
	if not new_state:
		return
		
	# Don't restart the state if we are already in it
	if current_state == new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
