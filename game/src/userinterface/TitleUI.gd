extends Control

func _ready() -> void:
	$PlayGame.connect("pressed", self, "_on_Button_pressed", [$PlayGame.name])
	$DevRoom.connect("pressed", self, "_on_Button_pressed", [$DevRoom.name])
	$QuitGame.connect("pressed", self, "_on_Button_pressed", [$QuitGame.name])

func _on_Button_pressed(name):
	match name:
		"PlayGame":
			print("New Game")
			get_tree().change_scene("res://src/level/Debug.tscn")
		"DevRoom":
			print("DevRoom")
		"QuitGame":
			print("Quit Game")
			get_tree().quit()
