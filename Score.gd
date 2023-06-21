"""
File: Score.gd
Description: This file control the score screen.
Author: Martí Llurba
Date: 20/05/2023
Version: 1.9
"""

extends Control


# Save in variables the paths 
onready var EditScoreLabel 	 = $CenterContainer/VBoxContainer/SeqContainer/HBoxContainer/EditedContainer/HBoxContainer/ScoreLabel
onready var OriginScoreLabel = $CenterContainer/VBoxContainer/SeqContainer/HBoxContainer/OriginalContainer/HBoxContainer/ScoreLabel
onready var FEditedLabel 	 = $CenterContainer/VBoxContainer/SeqContainer/HBoxContainer/EditedContainer/FEditedLabel
onready var SEditedLabel 	 = $CenterContainer/VBoxContainer/SeqContainer/HBoxContainer/EditedContainer/SEditedLabel
onready var FOriginLabel 	 = $CenterContainer/VBoxContainer/SeqContainer/HBoxContainer/OriginalContainer/FOriginLabel
onready var SOriginLabel 	 = $CenterContainer/VBoxContainer/SeqContainer/HBoxContainer/OriginalContainer/SOriginLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	"""
	This funciton hide the scene
	"""
	
	# Hide the scene
	hide()




# This function display the edited score
func drawEditedSore(score):
	"""
	This function recive an score value and display them in the label.
	"""
	
	# Play the sound
	$Sound.play()
	
	# Add value to the label
	EditScoreLabel.text = str(score)
	
	# Start timer
	$Timer.start()




# This function display the original score
func drawOriginalSore(score):
	"""
	This function add value to the label
	"""
	
	# Add value to the label
	OriginScoreLabel.text = str(score)




# This function display the edited first sequence
func drawEditedFSeq(FSeq):
	"""
	This function add value to the label
	"""
	
	# Add style in the label
	$Styles.labelStyle(FEditedLabel)
	$Styles._fonts(FEditedLabel, 24)
	
	# Add value to the label
	FEditedLabel.text = str(FSeq)




# This function display the edited second sequence
func drawEditedSSeq(SSeq):
	"""
	This function add value to the label
	"""
	
	# Add style to the lable
	$Styles.labelStyle(SEditedLabel)
	$Styles._fonts(SEditedLabel, 24)
	
	# Add value to the label
	SEditedLabel.text = str(SSeq)




# This function display the original first sequence
func drawOriginalFSeq(FSeq):
	"""
	This function add value to the label
	"""
	
	# Add style to the label
	$Styles.labelStyle(FOriginLabel)
	$Styles._fonts(FOriginLabel, 24)
	
	# Add value to the label
	FOriginLabel.text = str(FSeq)




# This function display the original second sequence
func drawOriginalSSeq(SSeq):
	"""
	This function add value to the label
	"""
	
	# Add styles to the label
	$Styles.labelStyle(SOriginLabel)
	$Styles._fonts(SOriginLabel, 24)
	
	# Add value to the label
	SOriginLabel.text = str(SSeq)




# This function change the scene
func _on_Timer_timeout():
	"""
	This funciton is connected to the timeout signal from the timer
	"""
	
	# Change the scene
	var _change = get_tree().change_scene("res://Main.tscn")
	
