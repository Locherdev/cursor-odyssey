extends CanvasLayer

const bbcode_start = "[shake rate=30 level=20][wave amp=20 freq=20][tornado radius=5 freq=5][center]"
const bbcode_end = "[/center][/tornado][/wave][/shake]"

func _ready() -> void: if Globals.connect("death",self, "_on_death") != OK: Globals.error_connect(self)
func _on_death() -> void: $AnimationPlayer.play("black")
func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void: 
	$Control/OrbCount.set_bbcode(bbcode_start + str(Globals.orb_count) + bbcode_end)
	$Control.visible = true
# warning-ignore:return_value_discarded
func _on_Button_pressed() -> void: get_tree().change_scene("res://src/level/Titlescreen.tscn")
