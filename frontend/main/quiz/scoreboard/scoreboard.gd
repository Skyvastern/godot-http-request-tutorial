extends Control
class_name Scoreboard

@export_group("UI")
@export var score: Label
@export var continue_btn: Button
@export var status: Status

@export_group("References")
@export var score_api_parse: ScoreAPI_Parse
@export_file("*.tscn") var main_menu_path: String


func _ready() -> void:
	continue_btn.pressed.connect(_on_continue_btn_pressed)
	score_api_parse.parsed.connect(_on_api_response_parsed)
	
	status.show_loader("Saving score to the cloud...")
	continue_btn.visible = false


func save_stats(correct_answers: int, total_questions: int) -> void:
	score.text = "Score: " + str(correct_answers) + "/" + str(total_questions)
	score_api_parse.make_request(correct_answers)


func _on_continue_btn_pressed() -> void:
	Global.load_menu(self, main_menu_path)


func _on_api_response_parsed(data: Dictionary) -> void:
	var message: String = data["message"]
	
	if message == "Success":
		status.hide_loader()
		continue_btn.visible = true
	else:
		status.show_error(message)
