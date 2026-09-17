extends Control

@onready var grid = $GridContainer
@onready var template_button = $GridContainer/TemplateButton

func _ready():
	# Setup the first button manually
	template_button.text = "1"
	# The .bind() trick tells the button to remember its specific number!
	template_button.pressed.connect(_on_level_button_pressed.bind(1))
	
	# Loop from 2 up to 50
	for i in range(2, 51):
		var new_button = template_button.duplicate()
		new_button.text = str(i) # Set the text to the current number
		
		grid.add_child(new_button) # Drop it into the GridContainer
		
		# Connect the signal and bind the current loop number to it
		new_button.pressed.connect(_on_level_button_pressed.bind(i))

# This single function handles all 50 buttons!
func _on_level_button_pressed(level_number: int):
	print("The player clicked button number: ", level_number)
	
	# Later, we can do something like:
	# if level_number == 1:
	#     TransitionManager.switch_to(TransitionManager.Scene.MAIN_LEVEL)
