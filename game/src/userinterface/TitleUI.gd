extends Control

func _ready() -> void:
	if $Easy.connect("pressed", self, "_on_Button_pressed", [$Easy.name]) != OK: Globals.error_connect(self.name)
	if $Normal.connect("pressed", self, "_on_Button_pressed", [$Normal.name]) != OK: Globals.error_connect(self.name)
	if $Hard.connect("pressed", self, "_on_Button_pressed", [$Hard.name]) != OK: Globals.error_connect(self.name)
	if $Highscores.connect("pressed", self, "_on_Button_pressed", [$Highscores.name]) != OK: Globals.error_connect(self.name)
	if $WindowDialog/OK.connect("pressed", self, "_on_Button_pressed", [$WindowDialog/OK.name]) != OK: Globals.error_connect(self.name)
	$WindowDialog.get_close_button().hide()

func _on_Button_pressed(name):
	match name:
		"Easy": 
			Globals.difficulty = 0
			var _success = get_tree().change_scene("res://src/level/Level.tscn")
		"Normal": 
			Globals.difficulty = 1
			var _success = get_tree().change_scene("res://src/level/Level.tscn")
		"Hard": 
			Globals.difficulty = 2
			var _success = get_tree().change_scene("res://src/level/Level.tscn")
		"Highscores": _toggle_popup()
		"OK": _toggle_popup()

func _toggle_popup():
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		$WindowDialog.visible = new_pause_state

func _on_WindowDialog_popup_hide() -> void: get_tree().paused = false
