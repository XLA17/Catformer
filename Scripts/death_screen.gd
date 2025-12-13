extends Control

@onready var menuLevel = preload("res://Scenes/levels_menu.tscn")
signal restartLevel

func _on_restart_button_down() -> void:
	Ui.deathVisibility(false)
	emit_signal("restartLevel")


func _on_menu_button_down() -> void:
	Ui.deathVisibility(false)
	Ui.heartsVisibility(false)
	get_tree().change_scene_to_packed(menuLevel)
