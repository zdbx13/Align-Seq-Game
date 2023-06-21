"""
File: DB.gd
Description: This file make a http request and save the data recived
Author: Martí Llurba
Date: 11/05/2023
Version: 1.1
"""

extends Node


# Define signals to call them from an other file
signal request_finished(JsonData)
signal score_recived(responce)
signal best_align(responce)


# This function recive the request data, pase the data and send the data with a signal
func _on_request_completed(_result, _response_code, _headers, body):
	""" 
	This function recive result, responce_code, headers and body,
	we catch the body, who have the content, and pase them to format the data,
	finaly emit a signal who contins the parsed data
	
	Example of data parsed:
	{ress:
		[{
			id:4, 
			organism:Arabidopsis thaliana, 
			sequence:TGCTAAGTCTACCGCT}, 
		{
			id:8, 
			organism:Mus musculus, 
			sequence:GATCTGTCGTTGACTC
		}]
	}
	"""

	# Parse data and save them in a var
	var json = JSON.parse(body.get_string_from_utf8())

	# Select the resps object
	var JsonData = json.result.ress

	# Emit a signal with JsonData values
	emit_signal("request_finished", JsonData)




# This function make a request
func make_request():
	"""
	This fucntion make a request to the serever
	"""
	
	# Save paht in a variable
	var http_request = $HTTPRequest
	
	# Make a request
	http_request.request("http://188.34.153.93/api/games/second", ["Access-Control-Allow-Origin"], HTTPClient.METHOD_GET)




# This function send data to server 
func sendModifiedData(sendJson):
	"""
	This function send modified sequences to the server.
	
	Example of sendJson:
	{"f_seq":"GATA", "s_seq":"GATA"}
	"""
	
	# Save path in a variable
	var http_request = $SendModifiedHTTPRequest
	
	
	# Parse data
	var body = JSON.print(sendJson)
	
	# Define headers
	var headers = ["Content-Type: application/json"]
	
	# Make request
	var _data = http_request.request("http://188.34.153.93/api/games/scores", headers, true, HTTPClient.METHOD_POST, body)




# This function recive a responce from sendModifiedData
func _on_SendHTTPRequest_request_completed(_result, _response_code, _headers, body):
	"""
	This function recive data from sendModifiedData reponce
	"""
	
	# Parse data
	var response = parse_json(body.get_string_from_utf8())
	
	# Emit signal with respoce values
	emit_signal("score_recived", response)
	print(response)




# This functio make a request
func sendOriginalData(sendJson):
	"""
	This function send original sequences to the server.
	
	Example of sendJson:
	{"f_seq":"GATA", "s_seq":"GATA"}
	"""
	
	# Save path in a variable
	var http_request = $SendOriginalHTTPRequest
	
	# Parse data
	var body = JSON.print(sendJson)
	
	# Define headers
	var headers = ["Content-Type: application/json"]
	
	# Make a request
	var _data = http_request.request("http://188.34.153.93/api/games/alineamiento", headers, true, HTTPClient.METHOD_POST, body)




# This function recive a responce from sendOriginalData
func _on_SendOriginalHTTPRequest_request_completed(_result, _response_code, _headers, body):
	"""
	This functio recive responce from sendOriginalData
	"""
	
	# Parse data
	var response = parse_json(body.get_string_from_utf8())
	
	sendScore(response)
	
	# Emit signal with response value
	emit_signal("best_align", response)



# This function sends data to the server, to store the puntuation in the ranking.
func sendScoreData(data):
	"""
	This function send score to the server.
	
	Example:
	{"puntuation":"30", "user_id":1, "topic_id":2}
	"""

	# Save path in a variable
	var http_request = $PostHTTPRequest
	
	# Parse data
	var body = JSON.print(data)
	
	# Define headers
	var headers = ["Content-Type: application/json"]
	
	# Make a request
	var _data = http_request.request("http://188.34.153.93/api/games/puntuations", headers, true, HTTPClient.METHOD_POST, body)
	



# This function send the socre to the server
func sendScore(score):
	"""
	This function create a dictionary and call the function sendData
	"""
	
	# Test setItem
	# var storeuser = JavaScript.eval("localStorage.setItem('user_id', 1)")
	
	# Get the user_if from localstorage
	var result = JavaScript.eval("localStorage.getItem('user_id')")

	# Save data in a variable
	var sendscore = score
	
	# Define a dictionary with the strings formated before
	var origin: Dictionary = {"puntuation":sendscore, "user_id":result, "topic_id":2}

	# Call sendOriginalData function
	sendScoreData(origin)
