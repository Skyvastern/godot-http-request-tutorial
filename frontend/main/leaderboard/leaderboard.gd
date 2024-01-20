extends Control
class_name Leaderboard

@export_group("UI")
@export var users: ScrollContainer
@export var fields: VBoxContainer
@export var status: Status

@export_group("References")
@export var leaderboard_api_parse: LeaderboardAPI_Parse
@export var leaderboard_row_scene: PackedScene


func _ready() -> void:
	leaderboard_api_parse.parsed.connect(_on_api_response_parsed)
	
	users.visible = false
	status.visible = true
	status.show_loader("Getting users data...")
	
	leaderboard_api_parse.make_request()


func _on_api_response_parsed(data: Dictionary) -> void:
	var message: String = data["message"]
	
	if message == "Success":
		status.hide_loader()
		status.visible = false
		
		var ranked_users: Array = data["ranked_users"]
		_update_users_list(ranked_users)
		
		users.visible = true
	else:
		status.show_error(message)


func _update_users_list(ranked_users: Array) -> void:
	for u in ranked_users:
		var leaderboard_row: LeaderboardRow = leaderboard_row_scene.instantiate()
		leaderboard_row.set_values(u[0], u[1])
		fields.add_child(leaderboard_row)
