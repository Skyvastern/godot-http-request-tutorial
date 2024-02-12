extends Control
class_name MainMenu

@export_group("UI")
@export var start_btn: Button
@export var leaderboard_btn: Button

@export_group("References")
@export_file("*.tscn") var quiz_selection_path: String
@export_file("*.tscn") var leaderboard_path: String


func _ready() -> void:
	start_btn.pressed.connect(_on_start_btn_pressed)
	leaderboard_btn.pressed.connect(_on_leaderboard_btn_pressed)


func _on_start_btn_pressed() -> void:
	Global.load_menu(self, quiz_selection_path)


func _on_leaderboard_btn_pressed() -> void:
	Global.load_menu(self, leaderboard_path)
