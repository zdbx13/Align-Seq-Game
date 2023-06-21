extends PanelContainer


# This function is executed when call the file
func _ready():
	"""
	This function stop music and hide control scene. 
	"""
	
	# Stop AmbientMusic
	$AmbientMusic.stop()

	# Hide control node
	$Control.hide()

# This function select a song
func playRandomSong():
	"""
	This function select a random song.
	"""
	
	# Add paths to the songs var
	var songs = ["res://art/music/Flowers.mp3",
				 "res://art/music/HeartOfTheOcean.mp3",
				 "res://art/music/MyHome.mp3",
				 "res://art/music/Wonderment.mp3"]
	
	# Select a random number in the list size
	var randomIndex = randi() % songs.size()
	
	# Select song with the index in randomIndex value
	var randomSongPath = songs[randomIndex]

	#print("Random index: ", randomIndex)
	
	# Load the song path
	var song = load(randomSongPath)
	
	# if song is loaded
	if song:
		
		# load song to the AmbientMusic
		$AmbientMusic.stream = song
		
		# Play the song
		$AmbientMusic.play()

	
	
# This function play a song
func _on_SongFinished():
	"""
	This function is connected to the end songs from playRandomSong.
	When a song end play an other song.
	"""
	
	# Call playRandomSong function
	playRandomSong()




# This fucntion show HowToPlay scene 
func _on_Button_pressed():
	"""
	This function is connected to HowToPlayButton, whe the button is pressed
	execute this function
	"""
	
	# Show HowToPlay
	$HowToPlay.show()




# This funciton show control
func _on_StartButton_pressed():
	"""
	This function is connected to StartButton , whe the button is pressed
	execute this function
	"""
	
	# Hide main
	$CenterContainer.hide()
	
	# Show control
	$Control.show()
	
	# Call playRandomSong function
	playRandomSong()



# This function hide the HowToPlay scene
func _on_HowToPlay_ClosePressed():
	"""
	This function is connected to Close , whe the button is pressed
	execute this function 
	"""
	
	# Hdide HowToPlay
	$HowToPlay.hide()
	
	# Show main
	$CenterContainer.show()



# This function stop the music
func _on_Control_show_score():
	"""
	This function is connected to show_score signal, when recive the signal execute
	the code.
	"""
	
	#Stop the music
	$AmbientMusic.stop()
