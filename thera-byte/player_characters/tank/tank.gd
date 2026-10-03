extends BasePlayer




func _on_melee_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(20)
		print("damage done")
	pass # Replace with function body.
