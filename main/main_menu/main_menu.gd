extends Control
class_name MainMenu

@export var start_btn: Button
@export_file("*.tscn") var quiz_selection_path: String


func _ready() -> void:
	start_btn.pressed.connect(_on_start_btn_pressed)


func _on_start_btn_pressed() -> void:
	var quiz_selection_res: Resource = load(quiz_selection_path)
	var quiz_selection: Node = quiz_selection_res.instantiate()
	get_parent().add_child(quiz_selection)
	
	queue_free()
