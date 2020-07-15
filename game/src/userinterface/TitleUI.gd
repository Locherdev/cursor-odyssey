extends Control

func _ready() -> void:
	if $PlayGame.connect("pressed", self, "_on_Button_pressed", [$PlayGame.name]) != OK: Globals.error_connect(self)
	if $DevRoom.connect("pressed", self, "_on_Button_pressed", [$DevRoom.name]) != OK: Globals.error_connect(self)
	if $QuitGame.connect("pressed", self, "_on_Button_pressed", [$QuitGame.name]) != OK: Globals.error_connect(self)
	if $WindowDialog/OK.connect("pressed", self, "_on_Button_pressed", [$WindowDialog/OK.name]) != OK: Globals.error_connect(self)

func _on_Button_pressed(name):
	match name:
		"PlayGame": get_tree().change_scene("res://src/level/Debug.tscn")
		"DevRoom": _toggle_popup()
		"QuitGame": _toggle_popup()
		"OK": _toggle_popup()

func _toggle_popup():
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		$WindowDialog.visible = new_pause_state
