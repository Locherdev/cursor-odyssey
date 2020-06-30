extends AudioStreamPlayer

signal track_ended()
var playback_position
var current_track = -1

func _ready() -> void:
	Globals.connect("set_music_volume", self, "_set_volume")
	Globals.connect("death", self, "_on_death")
	connect("finished", self, "_get_next_track")
	_get_next_track()

func _get_next_track() -> void:
	var tracks = Music.list_of_tracks(current_track)
	current_track = tracks[randi() % tracks.size()]
	var audiostream = load(Music.set_current_track(current_track))
	audiostream.set_loop(false)
	set_stream(audiostream)
	Globals.change_trackname()
	play()

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("debug")):
		Globals.append_to_statuslog(StatusMsg.debug_skipSong)
		_get_next_track()

func _set_volume(vol, flag) -> void:
	if flag:
		vol = clamp(vol + 0.1, 0.0, 1.0)
	else:
		vol = clamp(vol - 0.1, 0.0, 1.0)
	Globals.game_volume = vol
	Globals.append_to_statuslog(StatusMsg.system_volume(str(vol)))
	volume_db = linear2db(vol)

func _on_death() -> void:
	$AnimationPlayer.play("fadeout")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()

### NOT USED ###
func _pause_current_track() -> void:
	playback_position = get_playback_position()
	stop()

func _resume_current_track() -> void:
	play()
	seek(playback_position)
