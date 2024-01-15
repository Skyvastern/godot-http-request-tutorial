extends Button
class_name Option

@export var quiz: Quiz
@export var correct_option_style: StyleBoxFlat
@export var incorrect_option_style: StyleBoxFlat


func _ready() -> void:
	pressed.connect(_on_pressed)
	quiz.question_result.connect(_on_quiz_question_result)


func set_option(value: String) -> void:
	text = value


func _on_pressed() -> void:
	quiz.validate_option(text)


func _on_quiz_question_result(correct_option: String, selected_option: String) -> void:
	disabled = true
	
	if correct_option == text:
		set("theme_override_styles/disabled", correct_option_style)
	elif selected_option == text:
		set("theme_override_styles/disabled", incorrect_option_style)


func reset_state() -> void:
	set("theme_override_styles/disabled", null)
	disabled = false
