extends Control

func _ready() -> void: 
	if Globals.connect("open_pause", self, "_pausing") != OK: Globals.error_connect(self)
	$ConfirmationDialog.get_cancel().connect("pressed", self, "_cancel_prompt")

func _input(event: InputEvent) -> void: if event.is_action_pressed("ui_cancel") && !Globals.disable_uiCancel: _pausing()

func _pausing() -> void:
		var new_pause_state = not get_tree().paused
		if new_pause_state: _update_pause()
		get_tree().paused = new_pause_state
		visible = new_pause_state
		Globals.pause(new_pause_state)

func _update_pause() -> void:
	_update_track()
	_update_vol()

func _update_track(): $BlackOverlay/Track/ColorRect/Track.text = Music.current_track.name
func _update_vol(): 
	$BlackOverlay/HSlider.value = Globals.game_volume
	$BlackOverlay/Volume/Volume.text = str(int(Globals.game_volume * 100)) + "%"

func _next_track() -> void:
	Globals.skip_to_next_track()
	_update_track()

func _adjust_volume(value: float) -> void:
	Globals.set_music_volume(value)
	_update_vol()

### PROMPT ###
func _open_prompt() -> void: _visualize(false)
func _cancel_prompt(): _visualize(true)
func _visualize(enable):
	Globals.disable_uiCancel = !enable
	$BlackOverlay/Volume.visible = enable
	$BlackOverlay/Track.visible = enable
	$BlackOverlay/Title.visible = enable
	$BlackOverlay/Cancel.visible = enable
	$BlackOverlay/HSlider.visible = enable
	$ConfirmationDialog.visible = !enable

func _accept_prompt() -> void: 
	Globals.disable_uiCancel = false
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	Globals.pause(new_pause_state)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/level/Titlescreen.tscn")
