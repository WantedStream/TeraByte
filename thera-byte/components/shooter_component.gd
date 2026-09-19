class_name ShooterComponent
extends Node2D

@export var projectile_scene: PackedScene
@onready var spawn_point = $Marker2D

# This function holds the actual math for spawning a bullet
func fire_projectile(direction: Vector2) -> void:
	if projectile_scene:
		var bullet = projectile_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = spawn_point.global_position
		bullet.set_direction(direction)
