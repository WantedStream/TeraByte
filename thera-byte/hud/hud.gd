extends CanvasLayer

@onready var score_label = $ScoreLabel
#var total_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.coin_collected.connect(_on_coin_collected)
	
	pass # Replace with function body.

func _on_coin_collected(value: int):
	Values.last_score += value
	score_label.text = "Score: " + str(Values.last_score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
