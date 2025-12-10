extends Control


@export var number: int


signal buttonClicked(levelNumber)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/TextureButton/Label.text = str(number)


func _on_texture_button_mouse_entered() -> void:
	$AnimationPlayer.play("hover_level_button")


func _on_texture_button_mouse_exited() -> void:
	$AnimationPlayer.play_backwards("hover_level_button")


func _on_texture_button_pressed() -> void:
	emit_signal("buttonClicked", number)
