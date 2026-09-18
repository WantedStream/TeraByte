extends Control

@onready var score_label = $FinalScoreLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "Final Score: " + str(Values.last_score)
	Values.last_score=0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_button_pressed() -> void:
	TransitionManager.open_menu(TransitionManager.Menu.MAIN_MENU)
	
	pass # Replace with function body.
