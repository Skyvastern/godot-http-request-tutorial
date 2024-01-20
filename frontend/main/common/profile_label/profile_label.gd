extends Label
class_name ProfileLabel


func _ready() -> void:
	if Global.username != "":
		text = Global.username
