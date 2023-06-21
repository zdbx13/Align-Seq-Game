extends Node



#This function check the number of buttons displayed
func button(buttonsList, path):
	"""
	This funciton recive a list of button added and a path to add new buttons.
	
	Here check if the list have the correct lenth and add more if is necesary
	"""
	
	# Ensure buttons number reaches 19
	while buttonsList.size() < 19:
		
		# Create new button
		var button = Button.new()
		
		# Get the button id
		var buttonId = button.get_instance_id()
		
		# Add button as child
		path.add_child(button)
		
		# Call buttonStyle function
		$Styles.buttonStyle(button)
		
		# Save panel in the the list
		buttonsList.append(buttonId)
		
		# Define button with empty text value
		button.text = ""




# This function transform the arrays to string
func toString(array):
	"""
	This funciton recive an array and return a string with the array values.
	"""
	
	# Define an epmty string
	var strFormat = ""
	
	# For letter in array
	for letter in range(array.size()):
		
		# Add letter in strFormat 
		strFormat += str(array[letter])
		
	# Return strFormat
	return strFormat




# This function select the id from the object
func selectedID(RowChild):
	"""
	This function recive an path with objects and select the id
	of the selected object
	"""
	
	# For button in RowChild
	for button in RowChild:

		# Check if the button is pressed
		if button.is_pressed():

			# Save the object id in a varaible
			var id = button.get_instance_id()
			
			# Retunr the id
			return id





# This function update the oject values one position to the left
func moveRight(textList, child_index, SomePath):
	"""
	This function recive an array with the next object values, the id fo the child,
	and the path of the child.
	
	Next update the values one position to the right.
	"""

	# For item in textList size
	for i in range(textList.size()):
		
		# Save the next child id
		var nextButtonIndex = child_index + i + 1
		
		# Check if next child id is less than the number of children in SomePath
		if nextButtonIndex < SomePath.get_child_count():
			
			# Save the next child value
			var nextButton = SomePath.get_child(nextButtonIndex)
			
			# Update the text value
			nextButton.text = textList[i]




# This funciton update the oject values one position to the right
func moveLeft(textList, child_index, SomePath):
	"""
	This function receives an array with the next object values, the id of the child,
	and the path of the child.
	
	It updates the values one position to the left.
	"""
	
	# For item in textList size
	for i in range(1, textList.size()):
		
		# Save the previous child id
		var prevButtonIndex = child_index + i - 1
		
		# If the previous child id is greater than or equal to 0
		if prevButtonIndex >= 0:
			
			# Save the previous child value
			var prevButton = SomePath.get_child(prevButtonIndex)
			
			# Update the values
			prevButton.text = textList[i]




# This function delete the epmty last values in the array 
func EmptyArrayValues(textList):
	"""
	This function recive an array with the next object values, and delete the 
	last epmty values.
	"""
	
	# For item in textList size 
	for _item in range(textList.size()):
		
		# If the last index is empty
		if textList[textList.size() - 1] == "":
			
			# Delete last value
			textList.pop_back()
		
		# If last values in not empty
		else:
			
			# Exit the loop
			break
			
	# Save textList value in a new variable
	var filtredList = textList
	
	# Return new array
	return filtredList





# This function save the values to the childs of the path
func saveValues(SomePath):
	"""
	This function recive a path and save them childs values.
	"""
	
	# Define variables
	var labelValue
	var valueList = []
	
	# For child in path
	for child in range(SomePath.get_child_count()):
		
		# Save child in button
		var button = SomePath.get_child(child)

		# Update the labelValue value to button value 
		labelValue = button.text
	
		# If button is empyt
		if button.text == "":
		
			# Update the labelValue value to - 
			labelValue = "-"
		
		# Save labelValue value in labelValues list
		valueList.append(labelValue)
	
	# Return te valueList
	return valueList




# This function update the buttons values  
func updateValues(SomePath, selectedId):
	"""
	This function receives a path and the selected id and update the values position.
	"""

	# Define varialbes
	var buttonValue
	var textList = []
	var idList = []


	# For child in path childs
	for child_index in range(SomePath.get_child_count()):
		
		# Select the child
		var button = SomePath.get_child(child_index)
		
		# Get child id
		var child_instance_id = button.get_instance_id()
		
		# If child is the selected
		if selectedId == child_instance_id:
			
			# Save the button value
			buttonValue = button.text
				
			# If the values is not empty
			if buttonValue != "":
				
				# Save the value in the textList 
				textList.append(buttonValue)
			
				# For index in range of children starting from child_index + 1
				for index in range(child_index + 1, SomePath.get_child_count()):
					
					# Get the next child button from path
					var nextButton = SomePath.get_child(index)
					
					# Get the id of the next button
					var nextInstanceId = nextButton.get_instance_id()
					
					# Add the id to the idList
					idList.append(nextInstanceId)
					
					# Add next button value textList
					textList.append(nextButton.text)


				# Call EmptyArrayValues function
				var filtredList = EmptyArrayValues(textList)

		
				# Check if filtredList is not null and its size is less than idList size + 1
				if filtredList != null and filtredList.size() < idList.size() + 1:
					
					# Call the moveRight function
					moveRight(textList, child_index, SomePath)
					
					# Update the selected button value
					button.text = ""
					
					
			# If the button value si empty
			elif buttonValue == "":

					# Add the values in the textList
					textList.append(buttonValue)
					
					
					# For index in range of children starting from child_index + 1
					for index in range(child_index + 1, SomePath.get_child_count()):
					
						# Get the next child button from path
						var nextButton = SomePath.get_child(index)

						# Save the values in the textList
						textList.append(nextButton.text)
						
				
					# For index in range of children starting from child_index + 1
					for index in range(child_index + 1, SomePath.get_child_count()):
						
						# Get child
						var nextButton = SomePath.get_child(index)
						
						# Replace text with a white space
						nextButton.text = ""
					
					
					# Call moveLeft function
					moveLeft(textList, child_index, SomePath)




# This child delete all the child
func deleteChild(SomePath):
	"""
	This function delete all the childs from the path
	"""
	
	# For child in the path
	for child in range(SomePath.get_child_count()):
		
		# Get the child
		var del = SomePath.get_child(child)
		
		# Delete the child
		del.queue_free()


