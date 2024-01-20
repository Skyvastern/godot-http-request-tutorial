extends Node
class_name LoginAPI_Parse

signal parsed
@export var login_api: LoginAPI


func _ready() -> void:
	login_api.processed.connect(_on_login_api_processed)


func make_request(username: String, password: String) -> void:
	login_api.make_request(username, password)


func _on_login_api_processed(result: int, response_code: int, json: Dictionary) -> void:
	var data: Dictionary
	
	if result == 0 and response_code == 200:
		data = parse_response(json)
	else:
		data = {"message": "Unable to retrieve data."}
	
	parsed.emit(data)


func parse_response(json: Dictionary) -> Dictionary:
	return json
