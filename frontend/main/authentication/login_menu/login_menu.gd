extends Control
class_name LoginMenu

@export_group("UI")
@export var username_input: LineEdit
@export var password_input: LineEdit
@export var login_btn: Button

@export_group("References")
@export_file("*.tscn") var main_menu_path: String


func _ready() -> void:
	login_btn.pressed.connect(_on_login_btn_pressed)


func _on_login_btn_pressed() -> void:
	# Login
	# ...
	
	# Load main menu
	var main_menu_res: Resource = load(main_menu_path)
	var main_menu: Node = main_menu_res.instantiate()
	get_parent().add_child(main_menu)
	
	queue_free()
