extends Control

func _ready() -> void:
	Globals.spaceship = null
	for i in range(0, $ButtonContainer.get_child_count()): var _connection = $ButtonContainer.get_child(i).connect("pressed", self,"_on_Button_pressed", [i])
	var file2Check = File.new()
	if !file2Check.file_exists(Highscores.highscores_path): Highscores.write_highscores()

func _on_Button_pressed(button_id):
	match button_id:
		0, 1, 2: 
			Globals.difficulty = button_id
			var _success = get_tree().change_scene("res://src/level/WorldLevel_01.tscn")
		3: Globals.open_highscores()
		4: Globals.open_jukebox()
		5: Globals.open_pause()
