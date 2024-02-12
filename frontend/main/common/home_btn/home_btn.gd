extends Button
class_name HomeBtn

@export_file("*.tscn") var main_menu_path: String
@export_file("*.tscn") var authentication_menu_path: String


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if Global.access_token == "":
		Global.load_menu(get_parent(), authentication_menu_path)
	else:
		Global.load_menu(get_parent(), main_menu_path)
