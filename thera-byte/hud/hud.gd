extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var health_label = $HealthLabel
#var total_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.coin_collected.connect(_on_coin_collected)
	EventBus.player_damaged.connect(_on_player_damage)
	pass # Replace with function body.

func _on_coin_collected(value: int):
	Values.last_score += value
	score_label.text = "Score: " + str(Values.last_score)
func _on_player_damage(value: int):
	health_label.text = "Health: " + str(Values.ui_health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
