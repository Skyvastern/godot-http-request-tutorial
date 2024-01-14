extends Control

@export var trivia_api_parse: TriviaAPI_Parse
@export var open_ai_api_parse: OpenAI_API_Parse
@export_file("*.tscn") var quiz_path


func _ready() -> void:
	trivia_api_parse.parsed.connect(_on_api_response_parsed)
	open_ai_api_parse.parsed.connect(_on_api_response_parsed)
	
	#trivia_api_parse.make_request()
	open_ai_api_parse.make_request("Test my geography!")


func _on_api_response_parsed(quiz_data: Dictionary) -> void:
	var quiz_res: Resource = load(quiz_path)
	var quiz: Quiz = quiz_res.instantiate()
	get_parent().add_child(quiz)
	
	quiz.start_questions(quiz_data)
	
	queue_free()
