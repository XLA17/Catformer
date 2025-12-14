extends Control

@onready var menuLevel = preload("res://Scenes/levels_menu.tscn")

signal restartLevel
signal nextLevel

func _on_next_pressed() -> void:
	emit_signal("nextLevel")
	await get_tree().create_timer(1).timeout
	Ui.winVisibility(false)


func _on_restart_pressed() -> void:
	emit_signal("restartLevel")
	await get_tree().create_timer(1).timeout
	Ui.winVisibility(false)


func _on_menu_pressed() -> void:
	Ui.winVisibility(false)
	Ui.heartsVisibility(false)
	get_tree().change_scene_to_packed(menuLevel)

func enableNextButton(value: bool):
	$Next.disabled = !value
