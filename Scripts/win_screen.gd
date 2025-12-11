extends Control

@onready var menuLevel = preload("res://Scenes/levels_menu.tscn")

signal restartLevel


func _on_next_pressed() -> void:
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	Ui.deathVisibility(false)
	emit_signal("restartLevel")


func _on_menu_pressed() -> void:
	Ui.winVisibility(false)
	Ui.heartsVisibility(false)
	get_tree().change_scene_to_packed(menuLevel)
