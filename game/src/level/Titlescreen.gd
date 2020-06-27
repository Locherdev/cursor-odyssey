extends Node2D

func _ready() -> void:
	for button in $Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.name])

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
