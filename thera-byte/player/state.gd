extends Node
class_name State

signal transition(state, new_state_name)

var actor: Actor # Changed from player
var animator: AnimationPlayer

func enter():
	pass
func exit(): 
	pass
func physics_update(delta: float):
	pass
