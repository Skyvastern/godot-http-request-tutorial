extends Node
class_name ScoreAPI_Parse

signal parsed
@export var score_api: ScoreAPI


func _ready() -> void:
	score_api.processed.connect(_on_score_api_processed)


func make_request(score: int) -> void:
	score_api.make_request(score)


func _on_score_api_processed(result: int, response_code: int, json: Dictionary) -> void:
	var data: Dictionary
	
	if result == 0 and response_code == 200:
		data = parse_response(json)
	else:
		data = {"message": "Unable to save score to the cloud."}
	
	parsed.emit(data)


func parse_response(json: Dictionary) -> Dictionary:
	return json
