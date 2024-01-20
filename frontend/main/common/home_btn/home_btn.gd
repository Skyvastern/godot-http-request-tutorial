extends Button
class_name HomeBtn

@export_file("*.tscn") var main_menu_path: String
@export_file("*.tscn") var authentication_menu_path: String


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if Global.access_token == "":
		var authentication_menu_res: Resource = load(authentication_menu_path)
		var authentication_menu: Authentication = authentication_menu_res.instantiate()
		get_parent().get_parent().add_child(authentication_menu)
		
		get_parent().queue_free()
	else:
		var main_menu_res: Resource = load(main_menu_path)
		var main_menu: MainMenu = main_menu_res.instantiate()
		get_parent().get_parent().add_child(main_menu)
		
		get_parent().queue_free()
