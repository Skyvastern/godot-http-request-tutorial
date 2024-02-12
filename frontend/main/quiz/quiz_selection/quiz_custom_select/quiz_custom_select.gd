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
	Global.load_menu(
		self,
		get_questions_ui_path,
		[
			{
				"name": "get_custom_quiz",
				"args": [question_input.text]
			}
		]
	)
