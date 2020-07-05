extends AudioStreamPlayer

signal track_ended()
var playback_position
var current_track = -1
export(int, "Early Game", "Mid Game", "Late Game", "Bonus") var music_library


func _ready() -> void:
	Globals.connect("pause_game", self, "_pause_current_track")
	Globals.connect("resume_game", self, "_resume_current_track")
	Globals.connect("set_music_volume", self, "_set_volume")
	Globals.connect("death", self, "_on_death")
	connect("finished", self, "_get_next_track")
	_get_next_track()

func _get_next_track() -> void:
	var tracks = Music.list_of_tracks(music_library, current_track)
	var rand = randi() % tracks.size()
	current_track = tracks[rand] if music_library != 3 else rand
	var audiostream = load(Music.set_current_track(music_library, current_track, rand))
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
	var animation = $AnimationPlayer.get_animation('fadeout')
	var idx = animation.find_track(".:volume_db")
	animation.track_set_key_value(idx, 0, linear2db(Globals.game_volume))
	$AnimationPlayer.play("fadeout")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	stop()
	var audiostream = load(Music.track_gameover)
	set_stream(audiostream)
	volume_db = linear2db(Globals.game_volume)
	play()

### NOT USED ###
func _pause_current_track() -> void:
	playback_position = get_playback_position()
	stop()
	var audiostream = load(Music.track_options)
	set_stream(audiostream)
	play()

func _resume_current_track() -> void:
	stop()
	var audiostream = load(Music.set_current_track(music_library, current_track, current_track))
	audiostream.set_loop(false)
	set_stream(audiostream)
	play()
	seek(playback_position)
