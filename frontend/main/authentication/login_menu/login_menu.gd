extends Control
class_name LoginMenu

@export_group("UI")
@export var username_input: LineEdit
@export var password_input: LineEdit
@export var login_btn: Button
@export var status: Status

@export_group("References")
@export var login_api_parse: LoginAPI_Parse
@export_file("*.tscn") var main_menu_path: String


func _ready() -> void:
	login_btn.pressed.connect(_on_login_btn_pressed)
	login_api_parse.parsed.connect(_on_api_response_parsed)
	
	status.hide_loader()


func _on_login_btn_pressed() -> void:
	login_api_parse.make_request(
		username_input.text,
		password_input.text
	)
	
	status.show_loader("Logging in...")


func _on_api_response_parsed(data: Dictionary) -> void:
	var message: String = data["message"]
	
	if message == "Success":
		Global.username = data["username"]
		Global.access_token = data["access_token"]
		
		# Load main menu
		Global.load_menu(self, main_menu_path)
	else:
		status.show_error(message)
