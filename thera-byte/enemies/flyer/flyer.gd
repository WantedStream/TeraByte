extends Enemy


func _ready() -> void:
	# Make sure the base Enemy/Actor ready functions still run
	super()

# Delete the _physics_process with gravity entirely! The State Machine handles that now.

func _on_detection_zone_body_entered(body: Node2D) -> void:
	print("Player entered fly zone")
	# 1. Assign the player body to the target variable
	target = body
	# 2. Force the State Machine to switch to the Fly node
	state_machine.force_transition("fly")


func _on_detection_zone_body_exited(_body: Node2D) -> void:
	print("Player exited fly zone")
	# 1. Clear the target so the flyer stops chasing
	target = null
	# 2. Force the State Machine to go back to sitting still
	state_machine.force_transition("idle")
