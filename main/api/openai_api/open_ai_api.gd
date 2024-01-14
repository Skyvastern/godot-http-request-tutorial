extends HTTPRequest
class_name OpenAI_API

signal processed
var url: String = "https://api.openai.com/v1/chat/completions"


func _ready() -> void:
	request_completed.connect(_on_request_completed)


func make_request(question: String) -> void:
	var headers: PackedStringArray = [
		"Content-Type: application/json",
		"Authorization: Bearer " + ENV.OPEN_AI_API_KEY
	]
	
	var request_payload: String = JSON.stringify({
		"model": "gpt-3.5-turbo-1106",
		"response_format": {
			"type": "json_object"
		},
		"messages": [
			{
				"role": "system",
				"content": "You are the quiz master, who always gives response in JSON format. Give me 10 questions related to the question I ask. It should have 4 options, with one correct among them. This is the format: {\"message\":\"Success\",\"questions\":[{\"question\":\"String\",\"correct_answer\":\"String\",\"options\":[\"String\",\"String\",\"String\",\"String\"]}]} and if the question doesn't make sense then the format should be: {\"message\":\"Invalid question\",\"questions\":[]}"
			},
			{
				"role": "user",
				"content": question
			}
		]
	})
	
	var error = request(url, headers, HTTPClient.METHOD_POST, request_payload)
	if error != OK:
		push_error("Couldn't make the request.")


func _on_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var json: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	processed.emit(result, response_code, json)
