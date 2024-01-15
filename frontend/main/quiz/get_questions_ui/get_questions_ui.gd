extends Control
class_name GetQuestionsUI

@export_group("UI")
@export var loader: TextureRect
@export var status: Label
@export var error_msg: Label
@export var back_btn: Button

@export_group("References")
@export var trivia_api_parse: TriviaAPI_Parse
@export var open_ai_api_parse: OpenAI_API_Parse
@export_file("*.tscn") var quiz_path
@export_file("*.tscn") var quiz_selection_path


func _ready() -> void:
	trivia_api_parse.parsed.connect(_on_api_response_parsed)
	open_ai_api_parse.parsed.connect(_on_api_response_parsed)
	back_btn.pressed.connect(_on_back_btn_pressed)
	
	_show_loader()


func get_random_quiz() -> void:
	trivia_api_parse.make_request()


func get_custom_quiz(question: String) -> void:
	open_ai_api_parse.make_request(question)


func _on_api_response_parsed(quiz_data: Dictionary) -> void:
	var message: String = quiz_data["message"]
	
	if message == "Success":
		var quiz_res: Resource = load(quiz_path)
		var quiz: Quiz = quiz_res.instantiate()
		get_parent().add_child(quiz)
		
		quiz.start_questions(quiz_data)
		
		queue_free()
	else:
		_show_error_msg(message)


func _show_loader() -> void:
	loader.visible = true
	status.visible = true
	error_msg.visible = false
	back_btn.visible = false


func _show_error_msg(message: String) -> void:
	loader.visible = false
	status.visible = false
	
	error_msg.text = message
	error_msg.visible = true
	
	back_btn.visible = true


func _on_back_btn_pressed() -> void:
	var quiz_selection_res: Resource = load(quiz_selection_path)
	var quiz_selection: QuizSelection = quiz_selection_res.instantiate()
	get_parent().add_child(quiz_selection)
	
	queue_free()
