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
	var quiz_selection_res: Resource = load(quiz_selection_path)
	var quiz_selection: Node = quiz_selection_res.instantiate()
	get_parent().add_child(quiz_selection)
	
	queue_free()


func _on_leaderboard_btn_pressed() -> void:
	var leaderboard_res: Resource = load(leaderboard_path)
	var leaderboard: Node = leaderboard_res.instantiate()
	get_parent().add_child(leaderboard)
	
	queue_free()
