extends Control

@export var trivia_api: TriviaAPI
@export var quiz_scene: PackedScene


func _ready() -> void:
	trivia_api.processed.connect(_on_trivia_api_processed)
	trivia_api.make_request()


func _on_trivia_api_processed(_result, _response, json) -> void:
	var quiz_data: Array[Dictionary] = parse_response(json)
	
	var quiz: Quiz = quiz_scene.instantiate()
	get_parent().add_child(quiz)
	quiz.start_questions(quiz_data)
	
	queue_free()


func parse_response(json: Dictionary) -> Array[Dictionary]:
	var quiz_data: Array[Dictionary] = []
	var results: Array = json["results"]
	
	for item in results:
		var question: String = item["question"]
		var correct_answer: String = item["correct_answer"]
		
		var options: Array[String] = []
		options.append(item["correct_answer"])
		options.append_array(item["incorrect_answers"])
		options.shuffle()
		
		quiz_data.append({
			"question": question,
			"correct_answer": correct_answer,
			"options": options
		})
	
	return quiz_data
