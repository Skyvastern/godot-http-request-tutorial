extends Control
class_name Quiz

signal question_result
var index: int = -1
var quiz_data: Array[Dictionary]
var total_correct_answers: int = 0

@export_group("UI")
@export var question_label: Label
@export var options: Array[Option]
@export var continue_btn: Button

@export_group("References")
@export var scoreboard_scene: PackedScene


func _ready() -> void:
	continue_btn.pressed.connect(_on_continue_btn_pressed)


func start_questions(new_quiz_data: Array[Dictionary]) -> void:
	quiz_data = new_quiz_data
	index = -1
	total_correct_answers = 0
	
	_next_question()
	_reset_ui()


func _next_question() -> void:
	index += 1
	if index >= quiz_data.size():
		var scoreboard: Scoreboard = scoreboard_scene.instantiate()
		get_parent().add_child(scoreboard)
		scoreboard.update_ui(total_correct_answers, quiz_data.size())
		
		queue_free()
		return
	
	var question_data: String = quiz_data[index]["question"]
	var options_data: Array[String] = quiz_data[index]["options"]
	_update_ui(question_data, options_data)


func _update_ui(question_data: String, options_data: Array[String]) -> void:
	question_label.text = question_data
	
	for i in range(options.size()):
		var op_text: String = options_data[i]
		options[i].set_option(op_text)


func _reset_ui() -> void:
	continue_btn.visible = false
	for op in options:
		op.reset_state()


func validate_option(selected_option: String) -> void:
	var correct_option: String = quiz_data[index]["correct_answer"]
	question_result.emit(correct_option, selected_option)
	
	if correct_option == selected_option:
		total_correct_answers += 1
	
	continue_btn.visible = true


func _on_continue_btn_pressed() -> void:
	_next_question()
	_reset_ui()
