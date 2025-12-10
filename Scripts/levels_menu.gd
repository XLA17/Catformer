extends Control


@onready var level = preload("res://Scenes/main.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for element in $HBoxContainer.get_children():
		element.connect("buttonClicked", Callable(self, "_on_button_clicked"))


func _on_button_clicked(number):
	Globals.levelNumber = number
	get_tree().change_scene_to_packed(level)
