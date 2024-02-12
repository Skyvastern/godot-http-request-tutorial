extends Node
class_name Textgen_API_Parse

signal parsed
@export var textgen_api: Textgen_API


func _ready() -> void:
	textgen_api.processed.connect(_on_textgen_api_processed)


func make_request(question: String) -> void:
	textgen_api.make_request(question)


func _on_textgen_api_processed(result: int, response_code: int, json: Dictionary) -> void:
	var quiz_data: Dictionary
	
	if result == 0 and response_code == 200:
		var content: String = json["choices"][0]["message"]["content"]
		quiz_data = JSON.parse_string(content)
	else:
		quiz_data = {"message": "Unable to retrieve quiz data."}
	
	parsed.emit(quiz_data)
