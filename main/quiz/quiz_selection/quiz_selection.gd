extends Control
class_name QuizSelection

@export_group("UI")
@export var random_btn: Button
@export var custom_btn: Button

@export_group("References")
@export_file("*.tscn") var get_questions_ui_path: String
@export_file("*.tscn") var quiz_custom_select_path: String


func _ready() -> void:
	random_btn.pressed.connect(_on_random_btn_pressed)
	custom_btn.pressed.connect(_on_custom_btn_pressed)


func _on_random_btn_pressed() -> void:
	var get_questions_ui_res: Resource = load(get_questions_ui_path)
	var get_questions_ui: GetQuestionsUI = get_questions_ui_res.instantiate()
	get_parent().add_child(get_questions_ui)
	
	get_questions_ui.get_random_quiz()
	
	queue_free()


func _on_custom_btn_pressed() -> void:
	var quiz_custom_select_res: Resource = load(quiz_custom_select_path)
	var quiz_custom_select: QuizCustomSelect = quiz_custom_select_res.instantiate()
	get_parent().add_child(quiz_custom_select)
	
	queue_free()
