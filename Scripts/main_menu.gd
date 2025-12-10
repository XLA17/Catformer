extends Control


@onready var level = preload("res://Scenes/levels_menu.tscn")


func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_start_button_down() -> void:
	get_tree().change_scene_to_packed(level)
