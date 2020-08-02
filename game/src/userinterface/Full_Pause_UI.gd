extends "res://src/userinterface/Basic_Pause_UI.gd"

onready var current_track = $BlackOverlay/Track/ColorRect/Track

func _ready() -> void: 
	$ConfirmationDialog.get_cancel().connect("pressed", self, "_cancel_prompt")
	$ConfirmationDialog.get_close_button().visible = false
	
func _input(event: InputEvent) -> void: if event.is_action_pressed("ui_cancel") && !Globals.disable_uiCancel: _pausing()

func _update_pause() -> void:
	current_track.text = Music.current_track.name
	._update_pause()

func _next_track() -> void:
	Globals.skip_to_next_track()
	current_track.text = Music.current_track.name

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
