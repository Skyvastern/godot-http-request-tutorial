extends Node
class_name SignupAPI_Parse

signal parsed
@export var signup_api: SignupAPI


func _ready() -> void:
	signup_api.processed.connect(_on_signup_api_processed)


func make_request(username: String, password: String) -> void:
	signup_api.make_request(username, password)


func _on_signup_api_processed(result: int, response_code: int, json: Dictionary) -> void:
	var data: Dictionary
	
	if result == 0 and response_code == 200:
		data = parse_response(json)
	else:
		data = {"message": "Unable to retrieve data."}
	
	parsed.emit(data)


func parse_response(json: Dictionary) -> Dictionary:
	return json
