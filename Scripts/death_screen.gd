extends Control

@onready var menuLevel = preload("res://Scenes/main_menu.tscn")
signal restartLevel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_down() -> void:
	Ui.deathVisibility(false)
	emit_signal("restartLevel")


func _on_menu_button_down() -> void:
	Ui.deathVisibility(false)
	Ui.heartsVisibility(false)
	get_tree().change_scene_to_packed(menuLevel)
