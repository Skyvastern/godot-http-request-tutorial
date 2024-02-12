extends Node

var main: Main
var username: String
var access_token: String


func get_form_data(data: Dictionary) -> String:
	var parts: Array[String] = []
	
	for key in data.keys():
		var value: String = str(key).uri_encode() + "=" + str(data[key]).uri_encode()
		parts.append(value)
	
	return "&".join(parts)


func load_menu(current_menu: Node, new_menu_path: String, new_menu_callbacks: Array = []) -> void:
	var menu_res: Resource = load(new_menu_path)
	var menu: Node = menu_res.instantiate()
	main.add_child(menu)
	
	for fn in new_menu_callbacks:
		var fn_name = fn["name"]
		var fn_args = fn["args"]
		menu.callv(fn_name, fn_args)
	
	current_menu.queue_free()
