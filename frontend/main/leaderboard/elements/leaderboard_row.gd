extends HBoxContainer
class_name LeaderboardRow

@export var username_label: Label
@export var avg_score_label: Label


func set_values(username: String, avg_score: float) -> void:
	username_label.text = username
	avg_score_label.text = "%.1f" % avg_score
