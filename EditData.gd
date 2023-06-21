extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	"""
	This function define the scene hide default and apply styles to the label.
	"""
	
	# Hide scene
	hide()
	
	# Call labelStyles
	$Styles.labelStyle($ColorRect/CenterContainer/Label)


