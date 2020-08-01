extends Control

onready var bgm_slider = $BlackOverlay/BGM_Slider
onready var bgm_text = $BlackOverlay/BGM_Volume/Volume
onready var sfx_slider = $BlackOverlay/SFX_Slider
onready var sfx_text = $BlackOverlay/SFX_Volume/Volume
onready var current_track = $BlackOverlay/Track/ColorRect/Track

func _ready() -> void: 
	if Globals.connect("open_pause", self, "_pausing") != OK: Globals.error_connect(self.name)
	$ConfirmationDialog.get_cancel().connect("pressed", self, "_cancel_prompt")

func _input(event: InputEvent) -> void: if event.is_action_pressed("ui_cancel") && !Globals.disable_uiCancel: _pausing()

func _pausing() -> void:
		var new_pause_state = not get_tree().paused
		if new_pause_state: _update_pause()
		get_tree().paused = new_pause_state
		visible = new_pause_state
		Globals.pause(new_pause_state)

func _update_pause() -> void:
	current_track.text = Music.current_track.name
	bgm_slider.value = Globals.bgm_volume
	bgm_text.text = str(int(Globals.bgm_volume * 100)) + "%"
	sfx_slider.value = Globals.sfx_volume
	sfx_text.text = str(int(Globals.sfx_volume * 100)) + "%"

func _next_track() -> void:
	Globals.skip_to_next_track()
	current_track.text = Music.current_track.name

func _adjust_bgm_volume(value: float) -> void:
	Globals.set_bgm_volume(value)
	bgm_text.text = str(int(Globals.bgm_volume * 100)) + "%"

func _adjust_sfx_volume(value: float) -> void:
	Globals.set_sfx_volume(value)
	sfx_text.text = str(int(Globals.sfx_volume * 100)) + "%"

### PROMPT ###
func _open_prompt() -> void: _visualize(false)
func _cancel_prompt() -> void: _visualize(true)
func _visualize(enable) -> void:
	Globals.disable_uiCancel = !enable
	$BlackOverlay/BGM_Volume.visible = enable
	$BlackOverlay/SFX_Volume.visible = enable
	$BlackOverlay/Track.visible = enable
	$BlackOverlay/Title.visible = enable
	$BlackOverlay/Cancel.visible = enable
	bgm_slider.visible = enable
	sfx_slider.visible = enable
	$ConfirmationDialog.visible = !enable

func _accept_prompt() -> void: 
	Globals.disable_uiCancel = false
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	Globals.pause(new_pause_state)
	var _success = get_tree().change_scene("res://src/level/Titlescreen.tscn")
