extends Control
class_name Scoreboard

@export var score: Label
@export var continue_btn: Button
@export_file("*.tscn") var main_menu_path: String


func _ready() -> void:
	continue_btn.pressed.connect(_on_continue_btn_pressed)


func update_ui(correct_answers: int, total_questions: int) -> void:
	score.text = "Score: " + str(correct_answers) + "/" + str(total_questions)


func _on_continue_btn_pressed() -> void:
	var main_menu_res: Resource = load(main_menu_path)
	var main_menu: MainMenu = main_menu_res.instantiate()
	get_parent().add_child(main_menu)
	
	queue_free()
