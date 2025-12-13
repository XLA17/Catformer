extends CanvasLayer

signal anim_transition_finished

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "New_Level_Fade" or anim_name == "Next_Level_Fade":
		emit_signal("anim_transition_finished")
		#await get_tree().create_timer(1.0).timeout
		#$AnimationPlayer.play("Level_Fade_Out")
	#elif anim_name == "Level_Fade_Out":
