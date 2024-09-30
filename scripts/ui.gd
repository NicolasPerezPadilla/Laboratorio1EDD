extends Control

@export var menu: NinePatchRect




func _on_salir_pressed() -> void:
	get_tree().quit()


func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://opciones.tscn")


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
