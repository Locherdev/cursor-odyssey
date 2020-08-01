extends Control

onready var bgm_slider = $BlackOverlay/BGM_Slider
onready var bgm_text = $BlackOverlay/BGM_Volume/Volume
onready var sfx_slider = $BlackOverlay/SFX_Slider
onready var sfx_text = $BlackOverlay/SFX_Volume/Volume

func _ready() -> void: 
	if Globals.connect("open_pause", self, "_pausing") != OK: Globals.error_connect(self.name)

func _input(event: InputEvent) -> void: if event.is_action_pressed("ui_cancel") && !Globals.disable_uiCancel: _pausing()

func _pausing() -> void:
		var new_pause_state = not get_tree().paused
		if new_pause_state: 
			_update_pause()
			Music.play_audio($SFX_Player, Music.sounds_total[3].path)
		else:
			Music.play_audio($SFX_Player, Music.sounds_total[4].path)
		get_tree().paused = new_pause_state
		visible = new_pause_state
		Globals.pause(new_pause_state)

func _update_pause() -> void:
	bgm_slider.value = Globals.bgm_volume
	bgm_text.text = str(int(Globals.bgm_volume * 100)) + "%"
	sfx_slider.value = Globals.sfx_volume
	sfx_text.text = str(int(Globals.sfx_volume * 100)) + "%"

func _adjust_bgm_volume(value: float) -> void:
	Globals.set_bgm_volume(value)
	bgm_text.text = str(int(Globals.bgm_volume * 100)) + "%"

func _adjust_sfx_volume(value: float) -> void:
	Globals.set_sfx_volume(value)
	sfx_text.text = str(int(Globals.sfx_volume * 100)) + "%"
