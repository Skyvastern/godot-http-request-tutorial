extends Control
class_name Authentication

@export_group("UI")
@export var signup_btn: Button
@export var login_btn: Button

@export_group("References")
@export_file("*.tscn") var signup_menu_path: String
@export_file("*.tscn") var login_menu_path: String


func _ready() -> void:
	signup_btn.pressed.connect(_on_signup_btn_pressed)
	login_btn.pressed.connect(_on_login_btn_pressed)


func _on_signup_btn_pressed() -> void:
	Global.load_menu(self, signup_menu_path)


func _on_login_btn_pressed() -> void:
	Global.load_menu(self, login_menu_path)
