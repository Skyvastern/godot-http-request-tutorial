extends Node
class_name LeaderboardAPI_Parse

signal parsed
@export var leaderboard_api: LeaderboardAPI


func _ready() -> void:
	leaderboard_api.processed.connect(_on_leaderboard_api_processed)


func make_request() -> void:
	leaderboard_api.make_request()


func _on_leaderboard_api_processed(result: int, response_code: int, json: Dictionary) -> void:
	var data: Dictionary
	
	if result == 0 and response_code == 200:
		data = parse_response(json)
	else:
		data = {"message": "Unable to fetch user data."}
	
	parsed.emit(data)


func parse_response(json: Dictionary) -> Dictionary:
	return json
