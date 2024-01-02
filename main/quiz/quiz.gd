extends Control
class_name Quiz

signal question_result
var index: int = -1
var quiz_data: Array[Dictionary]

@export_group("UI")
@export var question_label: Label
@export var options: Array[Option]


func start_questions(new_quiz_data: Array[Dictionary]) -> void:
	quiz_data = new_quiz_data
	index = -1
	
	_next_question()


func _next_question() -> void:
	index += 1
	if index >= quiz_data.size():
		return
	
	var question_data: String = quiz_data[index]["question"]
	var options_data: Array[String] = quiz_data[index]["options"]
	_update_ui(question_data, options_data)


func _update_ui(question_data: String, options_data: Array[String]) -> void:
	question_label.text = question_data
	
	for i in range(options.size()):
		var op_text: String = options_data[i]
		options[i].set_option(op_text)


func validate_option(selected_option: String) -> void:
	var correct_option: String = quiz_data[index]["correct_answer"]
	question_result.emit(correct_option, selected_option)
