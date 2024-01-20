extends Node

var username: String
var access_token: String


func get_form_data(data: Dictionary) -> String:
	var parts: Array[String] = []
	
	for key in data.keys():
		var value: String = str(key).uri_encode() + "=" + str(data[key]).uri_encode()
		parts.append(value)
	
	return "&".join(parts)
