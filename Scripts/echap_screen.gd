extends Control

@onready var menuLevel = preload("res://Scenes/levels_menu.tscn")
signal restartLevel

func _on_restart_button_down() -> void:
	emit_signal("restartLevel")
	await get_tree().create_timer(1).timeout
	Ui.echapVisibility(false)


func _on_menu_button_down() -> void:
	Ui.echapVisibility(false)
	Ui.heartsVisibility(false)
	get_tree().change_scene_to_packed(menuLevel)
