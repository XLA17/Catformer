extends CanvasLayer

signal anim_transition_finished

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Level_Fade_In":
		emit_signal("anim_transition_finished")
	pass # Replace with function body.
