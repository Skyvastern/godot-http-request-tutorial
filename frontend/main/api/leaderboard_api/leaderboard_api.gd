extends HTTPRequest
class_name LeaderboardAPI

signal processed
var url: String = "http://127.0.0.1:8000/score/leaderboard"


func _ready() -> void:
	request_completed.connect(_on_request_completed)


func make_request() -> void:
	request(url)


func _on_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json: Dictionary = {}
	
	if result == 0:
		json = JSON.parse_string(body.get_string_from_utf8())
	
	processed.emit(result, response_code, json)
