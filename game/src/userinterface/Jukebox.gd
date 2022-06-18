extends Control

var volume_control: float
onready var track_containers = [
	$BlackOverlay/Background/MusicSelection/EasyTracks,
	$BlackOverlay/Background/MusicSelection/NormalTracks,
	$BlackOverlay/Background/MusicSelection/HardTracks,
	$BlackOverlay/Background/MusicSelection/SystemTracks
]

func _ready() -> void:
	if Globals.connect("open_jukebox", self, "_toggle_open") != OK: Globals.error_connect(self.name)
	volume_control = Globals.bgm_volume
	$BGM_Player.volume_db = linear2db(volume_control)
	Music.play_audio($BGM_Player, Music.tracks_total[16]["path"], "BGM")
	_connect_all_buttons()

func _connect_all_buttons() -> void:
	for groupSelector in $BlackOverlay/Background/GroupSelection.get_children(): 
		groupSelector.connect("pressed", self,"_select_group", [groupSelector.get_name()])
	for i in range(0, track_containers.size()):
		for tracks in track_containers[i].get_children(): 
			tracks.connect("pressed", self,"_select_track", [int(tracks.get_name())])

func _toggle_open() -> void:
	var new_pause_state = not get_tree().paused
	if new_pause_state:
		$SFX_Player.volume_db = linear2db(Globals.sfx_volume)
		$BlackOverlay/Background/BGM_Slider.value = Globals.bgm_volume
		Music.play_audio($SFX_Player, Music.sfx_sounds_total[3].path)
	else:
		Globals.set_bgm_volume(volume_control)
		Music.play_audio($SFX_Player, Music.sfx_sounds_total[4].path)
	get_tree().paused = new_pause_state
	visible = new_pause_state
	Globals.pause(new_pause_state)

func _select_group(button_name: String) -> void:
	for container in track_containers: container.visible = false
	track_containers[int(button_name.right(1))].visible = true

func _select_track(track_id: int) -> void: Music.play_audio($BGM_Player, Music.tracks_total[track_id].path, "BGM")
	

func _adjust_bgm_volume(value: float) -> void: 
	volume_control = value
	Globals.set_bgm_volume(value)
	$BGM_Player.volume_db = linear2db(value)
