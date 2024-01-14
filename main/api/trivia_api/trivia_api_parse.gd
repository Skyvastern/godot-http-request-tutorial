extends Node
class_name TriviaAPI_Parse

signal parsed
@export var trivia_api: TriviaAPI


func _ready() -> void:
	trivia_api.processed.connect(_on_trivia_api_processed)


func make_request() -> void:
	trivia_api.make_request()


func _on_trivia_api_processed(_result, response, json) -> void:
	var quiz_data: Dictionary
	
	if response == 200:
		quiz_data = parse_response(json)
	else:
		quiz_data = {"message": "Unable to retrieve quiz data."}
	
	parsed.emit(quiz_data)


func parse_response(json: Dictionary) -> Dictionary:
	var quiz_data: Dictionary = {
		"message": "Success",
		"questions": []
	}
	
	var results: Array = json["results"]
	
	for item in results:
		# Get the question
		var question: String = item["question"]
		question = _get_unescaped_string(question)
		
		# Get the options
		var correct_answer: String = item["correct_answer"]
		correct_answer = _get_unescaped_string(correct_answer)
		
		var options: Array = []
		options.append(item["correct_answer"])
		options.append_array(item["incorrect_answers"])
		options.shuffle()
		
		for i in range(options.size()):
			options[i] = _get_unescaped_string(options[i])
		
		# Add them to the quiz_data
		quiz_data["questions"].append({
			"question": question,
			"correct_answer": correct_answer,
			"options": options
		})
	
	return quiz_data


func _get_unescaped_string(encoded_string: String) -> String:
	var decoded_bytes: PackedByteArray = Marshalls.base64_to_raw(encoded_string)
	var decoded_string: String = decoded_bytes.get_string_from_utf8()
	return decoded_string
