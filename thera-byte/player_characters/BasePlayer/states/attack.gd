# Inside attack.gd (attached to the StateMachine in base_player.tscn)
extends State

func enter() -> void:
	actor.velocity.x = 0
	animator.play("attack")
	print("attack state")
	# The state lasts exactly as long as the animation takes to finish
	await animator.animation_finished
	print("idle state")
	transition.emit(self, "Idle")
