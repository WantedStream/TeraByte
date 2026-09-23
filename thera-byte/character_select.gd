extends Control

# Drag your different player .tscn files into these slots in the inspector
@export var knight_scene: PackedScene
@export var archer_scene: PackedScene
@export var magician_scene: PackedScene
@export var tank_scene: PackedScene

func _on_knight_button_pressed() -> void:
	Values.selected_character = knight_scene

func _on_archer_button_pressed() -> void:
	Values.selected_character = archer_scene


func _on_magician_button_pressed() -> void:
	Values.selected_character = magician_scene
 # Replace with function body.


func _on_tank_button_pressed() -> void:
	Values.selected_character = tank_scene
 # Replace with function body.
