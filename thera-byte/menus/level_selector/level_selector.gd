extends Control

@onready var grid = $GridContainer
@onready var template_button = $TemplateButton
@onready var prev_button = $HBoxContainer/PrevButton
@onready var next_button = $HBoxContainer/NextButton

var total_levels = TransitionManager.get_total_levels()
var levels_per_page = 20
var current_page = 0

func _ready():
	# Connect the navigation buttons
	prev_button.pressed.connect(_on_prev_pressed)
	next_button.pressed.connect(_on_next_pressed)
	
	# Draw the very first page
	update_page()

func update_page():
	# 1. Wipe the old buttons from the grid
	for child in grid.get_children():
		child.queue_free()
		
	# 2. Calculate the math for this specific page
	var start_level = (current_page * levels_per_page) + 1
	var end_level = min(start_level + levels_per_page, total_levels + 1)
	
	# 3. Generate just the buttons for this page
	for i in range(start_level, end_level):
		var new_button = template_button.duplicate()
		new_button.text = str(i)
		new_button.show() # Unhide the clone!
		grid.add_child(new_button)
		
		new_button.pressed.connect(_on_level_button_pressed.bind(i))
		
	# 4. Turn off the Prev/Next buttons if we are at the absolute edges
	prev_button.disabled = (current_page == 0)
	next_button.disabled = (end_level > total_levels)

func _on_prev_pressed():
	current_page -= 1
	update_page()

func _on_next_pressed():
	current_page += 1
	update_page()

func _on_level_button_pressed(level_number: int):
	print("The player clicked button number: ", level_number)
	TransitionManager.load_level(level_number)
