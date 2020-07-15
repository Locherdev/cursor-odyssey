extends CanvasLayer

func _ready() -> void: if Globals.connect("death",self, "_on_death") != OK: Globals.error_connect(self)
func _on_death() -> void: $AnimationPlayer.play("black")
func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void: $Control.visible = true
# warning-ignore:return_value_discarded
func _on_Button_pressed() -> void: get_tree().change_scene("res://src/level/Titlescreen.tscn")
