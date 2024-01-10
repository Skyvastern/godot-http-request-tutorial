extends HTTPRequest
class_name TriviaAPI

signal processed
var url: String = "https://opentdb.com/api.php?amount=10&type=multiple&encode=base64"


func _ready() -> void:
	request_completed.connect(_on_request_completed)


func make_request() -> void:
	request(url)


func _on_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.parse_string(body.get_string_from_utf8())
	processed.emit(result, response_code, json)
