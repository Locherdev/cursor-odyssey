extends Node2D

func _process(delta: float) -> void:
	if (Input.is_action_just_released("ui_page_up")):
		Globals.set_music_volume(true)
	if (Input.is_action_just_released("ui_page_down")):
		Globals.set_music_volume(false)
