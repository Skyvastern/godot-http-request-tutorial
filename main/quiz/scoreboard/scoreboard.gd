extends Control
class_name Scoreboard

@export var score: Label
@export var continue_btn: Button


func _ready() -> void:
	continue_btn.pressed.connect(_on_continue_btn_pressed)


func update_ui(correct_answers: int, total_questions: int) -> void:
	score.text = "Score: " + str(correct_answers) + "/" + str(total_questions)


func _on_continue_btn_pressed() -> void:
	queue_free()
