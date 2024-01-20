extends Control
class_name Status

@export var loader: TextureRect
@export var status_message: Label
@export var error_message: Label


func hide_loader() -> void:
	loader.visible = false
	status_message.visible = false
	error_message.visible = false


func show_loader(message: String) -> void:
	loader.visible = true
	error_message.visible = false
	
	status_message.text = message
	status_message.visible = true


func show_error(message: String) -> void:
	loader.visible = false
	status_message.visible = false
	
	error_message.text = message
	error_message.visible = true
