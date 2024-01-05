extends Control
class_name MainMenu

@export var start_btn: Button
@export_file("*.tscn") var get_questions_ui_path: String


func _ready() -> void:
	start_btn.pressed.connect(_on_start_btn_pressed)


func _on_start_btn_pressed() -> void:
	var get_questions_ui_res: Resource = load(get_questions_ui_path)
	var get_questions_ui: Node = get_questions_ui_res.instantiate()
	get_parent().add_child(get_questions_ui)
	
	queue_free()
