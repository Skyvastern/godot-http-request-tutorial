extends HTTPRequest
class_name ScoreAPI

signal processed
var url: String = "http://127.0.0.1:8000/score"


func _ready() -> void:
	request_completed.connect(_on_request_completed)


func make_request(score: int) -> void:
	request(
		url + "/" + str(score),
		["Authorization: Bearer " + Global.access_token],
		HTTPClient.METHOD_PUT
	)


func _on_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json: Dictionary = {}
	
	if result == 0:
		json = JSON.parse_string(body.get_string_from_utf8())
	
	processed.emit(result, response_code, json)
