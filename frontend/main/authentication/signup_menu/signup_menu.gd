extends Control
class_name SignupMenu

@export_group("UI")
@export var username_input: LineEdit
@export var password_input: LineEdit
@export var signup_btn: Button
@export var status: Status

@export_group("References")
@export var signup_api_parse: SignupAPI_Parse
@export_file("*.tscn") var main_menu_path: String


func _ready() -> void:
	signup_btn.pressed.connect(_on_signup_btn_pressed)
	signup_api_parse.parsed.connect(_on_api_response_parsed)
	
	status.hide_loader()


func _on_signup_btn_pressed() -> void:
	signup_api_parse.make_request(
		username_input.text,
		password_input.text
	)
	
	status.show_loader("Signing Up...")


func _on_api_response_parsed(data: Dictionary) -> void:
	var message: String = data["message"]
	
	if message == "Success":
		Global.username = data["username"]
		Global.access_token = data["access_token"]
		
		# Load main menu
		Global.load_menu(self, main_menu_path)
	else:
		status.show_error(message)
