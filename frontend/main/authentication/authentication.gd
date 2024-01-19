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
	var signup_menu_res: Resource = load(signup_menu_path)
	var signup_menu: Node = signup_menu_res.instantiate()
	get_parent().add_child(signup_menu)
	
	queue_free()


func _on_login_btn_pressed() -> void:
	var login_menu_res: Resource = load(login_menu_path)
	var login_menu: Node = login_menu_res.instantiate()
	get_parent().add_child(login_menu)
	
	queue_free()
