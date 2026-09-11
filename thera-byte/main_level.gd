extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.test_signal_fired.connect(on_test_signal)
	EventBus.coin_collected.connect(on_coin_collected)
	EventBus.player_damaged.connect(on_player_damaged)
	pass # Replace with function body.

func on_test_signal(message):
	print("THE MAIN LEVEL HEARD: ", message)
	
func on_coin_collected(value):
	print("THE LEVEL HEARD THE COIN! Value: ", value)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func on_player_damaged(value):
	print("player damaged:" ,value)
func _process(delta: float) -> void:
	pass
