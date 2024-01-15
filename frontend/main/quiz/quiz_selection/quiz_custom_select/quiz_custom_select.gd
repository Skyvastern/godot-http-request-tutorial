extends Control
class_name QuizCustomSelect

@export_group("UI")
@export var question_input: LineEdit
@export var submit_btn: Button

@export_group("References")
@export_file("*.tscn") var get_questions_ui_path: String


func _ready() -> void:
	submit_btn.pressed.connect(_on_submit_btn_pressed)


func _on_submit_btn_pressed() -> void:
	var get_questions_ui_res: Resource = load(get_questions_ui_path)
	var get_questions_ui: GetQuestionsUI = get_questions_ui_res.instantiate()
	get_parent().add_child(get_questions_ui)
	
	var question: String = question_input.text
	get_questions_ui.get_custom_quiz(question)
	
	queue_free()
