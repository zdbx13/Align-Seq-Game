extends Node

# This function create a new DynamicFont to text
func _fonts(SomePath, size):
	"""
	This function recive the parameters SomePath, the path of the text to add 
	the font, and size the size will have the text.
	
	Here create a new DynamicFont and define the letters style , and the size of the text.
	"""
	
	# Create a new DynamicFont
	var font = DynamicFont.new()
	
	# Define the text font to the new DynamicFont
	font.font_data = load("res://fonts/Cabin-VariableFont_wdth,wght.ttf")
	
	# Define the text size
	font.size = size

	# Asign the DynamicFont to the path
	SomePath.add_font_override("font", font)
	



# This function define the button style
func buttonStyle(button):
	"""
	This function recive a button and apply a concret style
	"""
	
	# Define button color
	button.modulate = Color(255,255,255,255)

	# Set the size of the button
	button.rect_min_size = Vector2(50, 100)
	
	_fonts(button, 34)
	




# This function define the label style
func labelStyle(letterLabel):
	"""
	This function recive a label and apply a concret style
	"""
	
	# Define the label position within the panel
	letterLabel.rect_position = Vector2(12, 14)
	
	# Define the label size
	letterLabel.rect_min_size = Vector2(26, 68)
	
	# Align the text
	letterLabel.align = Label.ALIGN_CENTER
	letterLabel.valign = Label.VALIGN_CENTER
	
	# Load and set the font for the label
	var font = load("res://fonts/Cabin-VariableFont_wdth,wght.ttf")
	letterLabel.add_font_override("font", font)


