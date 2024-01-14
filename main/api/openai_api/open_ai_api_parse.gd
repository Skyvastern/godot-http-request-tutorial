extends Node
class_name OpenAI_API_Parse

signal parsed
@export var open_ai_api: OpenAI_API


func _ready() -> void:
	open_ai_api.processed.connect(_on_open_ai_api_processed)


func make_request(question: String) -> void:
	open_ai_api.make_request(question)


func _on_open_ai_api_processed(_result: int, response_code: int, json: Dictionary) -> void:
	var quiz_data: Dictionary
	
	if response_code == 200:
		var content: String = json["choices"][0]["message"]["content"]
		quiz_data = JSON.parse_string(content)
	else:
		quiz_data = {"message": "Unable to retrieve quiz data."}
	
	parsed.emit(quiz_data)
