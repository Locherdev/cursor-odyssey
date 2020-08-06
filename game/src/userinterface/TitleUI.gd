extends Control

func _ready() -> void:
	
	if $Easy.connect("pressed", self, "_on_Button_pressed", [0]) != OK: Globals.error_connect(self.name)
	if $Normal.connect("pressed", self, "_on_Button_pressed", [1]) != OK: Globals.error_connect(self.name)
	if $Hard.connect("pressed", self, "_on_Button_pressed", [2]) != OK: Globals.error_connect(self.name)
	if $Highscores.connect("pressed", self, "_on_Button_pressed", [3]) != OK: Globals.error_connect(self.name)
	if $Jukebox.connect("pressed", self, "_on_Button_pressed", [4]) != OK: Globals.error_connect(self.name)
	if $Settings.connect("pressed", self, "_on_Button_pressed", [5]) != OK: Globals.error_connect(self.name)
	var file2Check = File.new()
	if !file2Check.file_exists(Highscores.highscores_path): Highscores.write_highscores()

func _on_Button_pressed(button_id):
	match button_id:
		0, 1, 2: 
			Globals.difficulty = button_id
			var _success = get_tree().change_scene("res://src/level/Level.tscn")
		3: Globals.open_highscores()
		4: print("Jukebox")
		5: Globals.open_pause()
