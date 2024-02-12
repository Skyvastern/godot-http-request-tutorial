extends Control
class_name GetQuestionsUI

@export_group("UI")
@export var status: Status
@export var back_btn: Button

@export_group("References")
@export var trivia_api_parse: TriviaAPI_Parse
@export var textgen_api_parse: Textgen_API_Parse
@export_file("*.tscn") var quiz_path
@export_file("*.tscn") var quiz_selection_path


func _ready() -> void:
	trivia_api_parse.parsed.connect(_on_api_response_parsed)
	textgen_api_parse.parsed.connect(_on_api_response_parsed)
	back_btn.pressed.connect(_on_back_btn_pressed)
	
	status.show_loader("Getting questions...")
	back_btn.visible = false


func get_random_quiz() -> void:
	trivia_api_parse.make_request()


func get_custom_quiz(question: String) -> void:
	textgen_api_parse.make_request(question)


func _on_api_response_parsed(quiz_data: Dictionary) -> void:
	var message: String = quiz_data["message"]
	
	if message == "Success":
		var quiz_res: Resource = load(quiz_path)
		var quiz: Quiz = quiz_res.instantiate()
		get_parent().add_child(quiz)
		
		quiz.start_questions(quiz_data)
		
		queue_free()
	else:
		status.show_error(message)
		back_btn.visible = true


func _on_back_btn_pressed() -> void:
	var quiz_selection_res: Resource = load(quiz_selection_path)
	var quiz_selection: QuizSelection = quiz_selection_res.instantiate()
	get_parent().add_child(quiz_selection)
	
	queue_free()
