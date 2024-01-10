extends Control

@export var trivia_api: TriviaAPI
@export_file("*.tscn") var quiz_path


func _ready() -> void:
	trivia_api.processed.connect(_on_trivia_api_processed)
	trivia_api.make_request()


func _on_trivia_api_processed(_result, _response, json) -> void:
	var quiz_res: Resource = load(quiz_path)
	var quiz: Quiz = quiz_res.instantiate()
	get_parent().add_child(quiz)
	
	var quiz_data: Array[Dictionary] = parse_response(json)
	quiz.start_questions(quiz_data)
	
	queue_free()


func parse_response(json: Dictionary) -> Array[Dictionary]:
	var quiz_data: Array[Dictionary] = []
	var results: Array = json["results"]
	
	for item in results:
		# Get the question
		var question: String = item["question"]
		question = _get_unescaped_string(question)
		
		# Get the options
		var correct_answer: String = item["correct_answer"]
		correct_answer = _get_unescaped_string(correct_answer)
		
		var options: Array[String] = []
		options.append(item["correct_answer"])
		options.append_array(item["incorrect_answers"])
		options.shuffle()
		
		for i in range(options.size()):
			options[i] = _get_unescaped_string(options[i])
		
		# Add them to the quiz_data
		quiz_data.append({
			"question": question,
			"correct_answer": correct_answer,
			"options": options
		})
	
	return quiz_data


func _get_unescaped_string(encoded_string: String) -> String:
	var decoded_bytes: PackedByteArray = Marshalls.base64_to_raw(encoded_string)
	var decoded_string: String = decoded_bytes.get_string_from_utf8()
	return decoded_string
