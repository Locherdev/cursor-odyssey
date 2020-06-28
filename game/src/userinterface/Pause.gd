extends Control

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_cancel")):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		Globals.pause(new_pause_state)
