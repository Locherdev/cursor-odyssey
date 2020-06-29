extends CanvasLayer

func _ready() -> void:
	Globals.connect("death",self, "_on_death")

func _on_death() -> void:
	$AnimationPlayer.play("black")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$Control.visible = true

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://src/level/Titlescreen.tscn")
