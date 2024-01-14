extends Node
class_name Main

@export var open_ai_api: OpenAI_API


func _ready() -> void:
	open_ai_api.processed.connect(_on_open_ai_api_processed)
	open_ai_api.make_request("Ask me about the solar system.")


func _on_open_ai_api_processed(_result: int, response_code: int, json: Dictionary) -> void:
	if response_code == 200:
		var content: String = json["choices"][0]["message"]["content"]
		var quiz_data: Dictionary = JSON.parse_string(content)
		print(quiz_data)
