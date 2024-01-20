extends HTTPRequest
class_name SignupAPI

signal processed
var url: String = "http://127.0.0.1:8000/signup"


func _ready() -> void:
	request_completed.connect(_on_request_completed)


func make_request(username: String, password: String) -> void:
	var request_payload: String = JSON.stringify({
		"username": username,
		"password": password
	})
	
	request(url, [], HTTPClient.METHOD_POST, request_payload)


func _on_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json: Dictionary = {}
	
	if result == 0:
		json = JSON.parse_string(body.get_string_from_utf8())
	
	processed.emit(result, response_code, json)
