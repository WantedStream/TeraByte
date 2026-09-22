class_name ShooterComponent
extends ActionComponent # Inherits the blueprint

@export var projectile_scene: PackedScene
@onready var spawn_point = $Marker2D

# Overwrite the empty blueprint with shooting math
func execute_action(direction: Vector2) -> void:
	if projectile_scene:
		var bullet = projectile_scene.instantiate()
		get_tree().current_scene.call_deferred("add_child", bullet)
		bullet.global_position = spawn_point.global_position
		bullet.set_direction(direction)
