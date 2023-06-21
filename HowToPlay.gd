extends Node2D

# Emit signal to call them in an other file
signal ClosePressed


# Called when the node enters the scene tree for the first time.
func _ready():
	"""
	This function hide the scene and call add rules function.
	"""
	
	# Hide scene
	hide()
	
	# Call addRules function
	addRules()




# This function display rules in the screen
func addRules():
	"""
	This function add a label for rule in the list and display them in the screen.
	"""
	
	# Define rule liest
	var ruleList = [
		"1 -> Observe the sequences",
		"2 -> Select the letter to move (mouse left botton)",
		"3 -> If you think you are wrong select  the white space place to turn back (mouse left button)",
		"4 -> When finish to move letters press the submit button"
	]
	
	# For rule in the list
	for rule in ruleList:
		
		# Create new label
		var label = Label.new()
		
		# Define as child from the path
		$ColorPicker/CenterContainer/VBoxContainer.add_child(label)
		
		# Add text in the label
		label.text = rule
		
		# Apply styles to the label
		$Styles.labelStyle(label)
		
	# Add new button
	var button = Button.new()
	
	# Define as child from the path
	$ColorPicker/VBoxContainer.add_child(button)
	
	# Add text to the button
	button.set_text("Close")
	
	# Define size of the button
	button.set_size(Vector2(50, 40))
	
	# Connect pressed signal to the _on_button_pressed function
	button.connect("pressed", self, "_on_button_pressed")




# This function emit a signal
func _on_button_pressed():
	"""
	When recive the pressed signal from addRules execute this code
	"""
	
	# Emit a signal
	emit_signal("ClosePressed")
	
