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
	Global.load_menu(
		self,
		get_questions_ui_path,
		[
			{
				"name": "get_random_quiz",
				"args": []
			}
		]
	)


func _on_custom_btn_pressed() -> void:
	Global.load_menu(self, quiz_custom_select_path)
