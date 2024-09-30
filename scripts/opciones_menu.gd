extends Control

var general_bus = AudioServer.get_bus_index("Master")


func _on_general_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(general_bus, value)
	if(value==-30):
		AudioServer.set_bus_mute(general_bus, true)
	else:
		AudioServer.set_bus_mute(general_bus, false)
		



func _on_resolucion_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1280,720))
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://ui.tscn")
