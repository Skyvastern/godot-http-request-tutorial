extends Node
class_name Main

@export var trivia_api: TriviaAPI


func _ready() -> void:
	trivia_api.processed.connect(_on_trivia_api_processed)
	trivia_api.make_request()


func _on_trivia_api_processed(_result, _response, json) -> void:
	print(json)
