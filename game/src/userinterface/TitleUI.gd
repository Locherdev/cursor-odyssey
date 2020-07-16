extends Control

func _ready() -> void:
	if $Easy.connect("pressed", self, "_on_Button_pressed", [$Easy.name]) != OK: Globals.error_connect(self)
	if $Normal.connect("pressed", self, "_on_Button_pressed", [$Normal.name]) != OK: Globals.error_connect(self)
	if $Hard.connect("pressed", self, "_on_Button_pressed", [$Hard.name]) != OK: Globals.error_connect(self)
	if $Highscores.connect("pressed", self, "_on_Button_pressed", [$Highscores.name]) != OK: Globals.error_connect(self)
	if $WindowDialog/OK.connect("pressed", self, "_on_Button_pressed", [$WindowDialog/OK.name]) != OK: Globals.error_connect(self)
	$WindowDialog.get_close_button().hide()

func _on_Button_pressed(name):
	match name:
# warning-ignore:return_value_discarded
		"Easy": 
			Globals.difficulty = 0
			get_tree().change_scene("res://src/level/Template.tscn")
		"Normal": 
			Globals.difficulty = 1
			get_tree().change_scene("res://src/level/Template.tscn")
		"Hard": 
			Globals.difficulty = 2
			get_tree().change_scene("res://src/level/Template.tscn")
		"Highscores": _toggle_popup()
		"OK": _toggle_popup()

func _toggle_popup():
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		$WindowDialog.visible = new_pause_state


func _on_WindowDialog_popup_hide() -> void:
	get_tree().paused = false
