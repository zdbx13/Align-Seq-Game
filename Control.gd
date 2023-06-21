extends Control

# Send the signals to call them in an other file or fuction
signal Request_end
signal show_score

# Define global variables
var JsonData
var MFSeq # Modified First Sequence
var MSSeq # Modified Second Sequence
var OFSeq # Orioginal First Sequence
var OSSeq # Orioginal Second Sequence

# Define empty array
var f_buttonList = []
var s_buttonList = []


# This function is executed when call the file
func _ready(): 
	"""
	In this function do a http request.
	"""

	$DB.make_request()





# This function update the JsonData variable value
func JSData(Data):
	"""
	This function recive "Data", the data who contain the request_finished signal,
	received from DataBase.gd, and update the JsonData value.
	
	In the end send a signal when JsonData have a value.
	"""
	
	# Update the varible value
	JsonData = Data
	
	# Send the signal Request_end
	emit_signal("Request_end")




# This function control the display sequences
func show_sequence():
	"""
	This fuction is conected to the signal Request_end, when recive the signal 
	execute the code.
	
	This code save the request data in a variables and display it in the screen.
	"""
	
	# Save JsonData in individual dictionaris
	var f_seq = JsonData[0]
	var s_seq = JsonData[1]

	# Display the organism names in the screen
	$CenterContainer/VLayout/OrganismColumns/Organism1/Label.text = f_seq.organism
	$CenterContainer/VLayout/OrganismColumns/Organism2/Label.text = s_seq.organism
	
	# Call the displayFirstSeq function
	displayFirstSeq(f_seq)

	# Call the displaySecondSeq function
	displaySecondSeq(s_seq)




# This function control the first sequence
func displayFirstSeq(f_seq):
	"""
	This function recive the f_seq paramenter, this parameter is a dictionary 
	who contains a sequence.
	
	Here display the panels and add letter in the panels
	"""

	
	# Update the variable value
	OFSeq = f_seq.sequence
	
	# For each letter in the sequence
	for letter in OFSeq:
		
		# Create a new button
		var button = Button.new()
		
		# Save id button value
		var buttonId = button.get_instance_id()
		
		# Add button as path child
		$CenterContainer/VLayout/FSeqColumns.add_child(button)
		
		# Call buttonStyle function
		$Styles.buttonStyle(button)
		

		# Save button in the list
		f_buttonList.append(buttonId)
		
		# Write the letter in the button
		button.text = str(letter)
		

	# Call btton function
	$Utils.button(f_buttonList, $CenterContainer/VLayout/FSeqColumns)




# This function control the second sequence
func displaySecondSeq(s_seq):
	"""
	This function receives the s_seq parameter, which is a dictionary 
	containing a sequence.
	
	Here, it displays the panels and adds letters to the panels.
	"""

	
	# Update the variable value
	OSSeq = s_seq.sequence
	
	# For each letter in the sequence
	for letter in OSSeq:
		
		# Create a new button
		var button = Button.new()
		

		# Save button id
		var buttonId = button.get_instance_id()
		
		
		# Add button as path child
		$CenterContainer/VLayout/SSeqColumns.add_child(button)
		
		# Call buttonStyle function
		$Styles.buttonStyle(button)
		

		# Save button in the list
		s_buttonList.append(buttonId)
		
		# Write the letter in the button
		button.text = str(letter)
		

	# Call button function
	$Utils.button(s_buttonList, $CenterContainer/VLayout/SSeqColumns)




func _physics_process(_delta):

	# Define variables
	var FSelectedId
	var SSelectedId
	
	
	# Save path in variables
	var FPath = $CenterContainer/VLayout/FSeqColumns
	var SPath = $CenterContainer/VLayout/SSeqColumns

	# Define an array with the buttons id
	var FRowChild = FPath.get_children()
	var SRowChild = SPath.get_children()
	

	# If press the left mouse button
	if Input.is_action_just_pressed("MoveRight"):
		
		# Save the result from selectedID fucntion
		FSelectedId = $Utils.selectedID(FRowChild)
		SSelectedId = $Utils.selectedID(SRowChild)
		
		# Call updateValues function
		$Utils.updateValues(FPath, FSelectedId)
		$Utils.updateValues(SPath, SSelectedId)






# This function restart the level before the user touch anything
func restart():
	"""
	This function call the deleteChild function to delete the edited data, and
	next call the show_sequence function to display the original structure.
	"""
	
	# Call the deleteChild() function
	deleteChild()
	
	# Call the show_sequence() functio
	show_sequence()




# This function delete all the child nodes 
func deleteChild():
	"""
	This function delete all the child nodes from the memory
	"""
	

	# Save paths in a variables
	var fSeqColumns = $CenterContainer/VLayout/FSeqColumns
	var sSeqColumns = $CenterContainer/VLayout/SSeqColumns
	
	# For every child in fSeqColumns
	for child in fSeqColumns.get_children():
	
		# Delete child
		child.queue_free()
		f_buttonList = []



	# For every child in sSeqColumns
	for child in sSeqColumns.get_children():
		
		# Delete child
		child.queue_free()
		s_buttonList = []




# This function change the sequences
func changeSeq():
	"""
	This function call the deleteChild function to delete the childs, and next
	make a new request to change the sequence who are displayed.
	"""
	
	# Call deleteChild function
	deleteChild()
	
	# Make a new requqest
	$DB.make_request()




# This function submit the data and preapre to send it to make an aligment
func submitData():
	"""
	This function create a list who contains the label values and save them in 
	a list to send them.
	"""
	
	# Save path in variables
	var fSeqColumns: HBoxContainer = $CenterContainer/VLayout/FSeqColumns
	var sSeqColumns: HBoxContainer = $CenterContainer/VLayout/SSeqColumns
	
	# Save the saveValues result in a varaible
	var fLabelValues: Array = $Utils.saveValues(fSeqColumns)
	var sLabelValues: Array = $Utils.saveValues(sSeqColumns)
	
	# Call formatData function
	formatData(fLabelValues, sLabelValues)
	
	# Call sendOriginal funciton
	sendOriginal()





# This function format the data to a dictionary
func formatData(fLabelValues: Array, sLabelValues: Array):
	"""
	This function format the Arrays and prepare a dictionary to send them to
	sendData function.
	
	Chek if the sequences are modified and send the data to the sendData or show
	an error missage.
	"""
	
	# Call toString fuction to convert arrays to strings
	var fSeqStr: String = $Utils.toString(fLabelValues)
	var sSeqStr: String = $Utils.toString(sLabelValues)
	
	# Remove trailing hyphens from the strings
	fSeqStr = fSeqStr.rstrip("-")
	sSeqStr = sSeqStr.rstrip("-")

	# Update the varialbe
	MFSeq = fSeqStr
	MSSeq = sSeqStr
	
	# Check if the sequences are modified
	if OFSeq != fSeqStr or OSSeq != sSeqStr:
		
		# Define a dictionary with the strings formated before
		var dict: Dictionary = {"f_seq":fSeqStr, "s_seq":sSeqStr}
	
		# Send dict variable to sendData function
		$DB.sendModifiedData(dict)
	
	
	# If sequences are not modified
	else:
		# Show EditeData scene
		$EditData.show()
		
		# Start the timer
		$EditTimer.start()
		
		# Disable the buttons in the path
		for child in range($CenterContainer/VLayout/ButtonColumns.get_child_count()):
			var button = $CenterContainer/VLayout/ButtonColumns.get_child(child)
			
			button.disabled = true
		
		# Disable the HowToPlayButton button
		$CenterContainer/VLayout/HBoxContainer/HowToPlayButton.disabled = true




# This function hide the EditData scene
func _on_EditTimer_timeout():
	"""
	This function hide the EditData scene and enable the buttons.
	"""
	
	# Hide EditData scene
	$EditData.hide()
	
	# Enable the buttons in the path
	for child in range($CenterContainer/VLayout/ButtonColumns.get_child_count()):
		var button = $CenterContainer/VLayout/ButtonColumns.get_child(child)
		
		button.disabled = false
	
	# Enable the HowToPlayButton button
	$CenterContainer/VLayout/HBoxContainer/HowToPlayButton.disabled = false




# This function send the original data to the server
func sendOriginal():
	"""
	This function create a dictionary and call the function sendOriginalData
	"""
	
	# Save data in a variable
	var Fseq = JsonData[0].sequence
	var Sseq = JsonData[1].sequence
	
	# Define a dictionary with the strings formated before
	var origin: Dictionary = {"f_seq":Fseq, "s_seq":Sseq}

	# Call sendOriginalData function
	$DB.sendOriginalData(origin)




# This function display the best align data
func _on_best_align_recived(responce):
	"""
	This function is connected to the best_signal in DB.gd file.
	When recive the signal the funciton recive the responce data (aligment data).
	"""
	
	# Save data in a variable
	var dict =  responce.alignment
	
	var score = dict.score
	
	var Fseq = dict.alignmentA
	var Sseq = dict.alignmentB
	
	# Display the data
	$Score.drawOriginalFSeq(Fseq)
	$Score.drawOriginalSSeq(Sseq)
	$Score.drawOriginalSore(score)




# This function display the edited align data
func _on_DB_score_recived(responce):
	"""
	This function is connected to the score_recived signal from DB.gd file.
	When recive the signal the funciton recive the responce data (aligment data).

	"""
	
	# Save data in a variable
	var score = responce.score
	
	# Call Score functions to display the values
	$Score.drawEditedFSeq(MFSeq)
	$Score.drawEditedSSeq(MSSeq)
	$Score.drawEditedSore(score)
	
	# Show Score scene
	$Score.show()
	
	# Emit show_score signal
	emit_signal("show_score")



# This function show HowToPlay scene
func _on_HowToPlayButton_pressed():
	"""
	This function show the how to play scence, when the HowToPlayButton is pressed.
	"""
	
	# Update the lists values
	f_buttonList = []
	s_buttonList = []
	
	# Restart the buttons
	$Utils.deleteChild($CenterContainer/VLayout/FSeqColumns)
	$Utils.deleteChild($CenterContainer/VLayout/SSeqColumns)
	
	# Show HowToPlay scene
	$HowToPlay.show()




# This funciton hide HowToPlay scene 
func _on_HowToPlay_ClosePressed():
	"""
	This funciton hide HowToPlay scene, when the close button is pressed.
	"""
	
	# Hide HowToPlay scene
	$HowToPlay.hide()
	
	# Call show_sequence function
	show_sequence()




## This function add new button
#func _on_Button_pressed():
#	"""
#	When the button is pressed add new button.
#	"""
#
#	# Create new button
#	var button = Button.new()
#
#	# Add button as path child
#	$CenterContainer/VLayout/SSeqColumns.add_child(button)
#
#	# Call buttonStyle function
#	$Styles.buttonStyle(button)
