extends AudioStreamPlayer

var playback_position
var current_track = -1
var skipped = false
export(int, "Early Game", "Mid Game", "Late Game", "Bonus") var music_library

func _ready() -> void:
	if Globals.connect("pause_game", self, "_pause_current_track") != OK: Globals.error_connect(self.name)
	if Globals.connect("resume_game", self, "_resume_current_track") != OK: Globals.error_connect(self.name)
	if Globals.connect("set_bgm_volume", self, "_set_volume") != OK: Globals.error_connect(self.name)
	if Globals.connect("skip_to_next_track", self, "_skip_song") != OK: Globals.error_connect(self.name)
	if Globals.connect("death", self, "_on_death") != OK: Globals.error_connect(self.name)
	if connect("finished", self, "_get_next_track") != OK: Globals.error_connect(self.name)
	music_library = _set_music_library()
	randomize()
	_get_next_track()

func _set_music_library() -> int:
	match Globals.difficulty:
		0: return 0
		1: return 1
		2: return 2
		_: return 3

func _skip_song() -> void:
	var tracks = Music.list_of_tracks(music_library, current_track)
	var rand = randi() % tracks.size()
	current_track = tracks[rand] if music_library != 3 else rand
# warning-ignore:return_value_discarded
	Music.set_current_track(music_library, current_track, rand)
	skipped = true
	Globals.change_trackname()
	
func _get_next_track() -> void:
	var tracks = Music.list_of_tracks(music_library, current_track)
	var rand = randi() % tracks.size()
	current_track = tracks[rand] if music_library != 3 else rand
	var audiostream = load(Music.set_current_track(music_library, current_track, rand))
	audiostream.set_loop(false)
	set_stream(audiostream)
	Globals.change_trackname()
	play()

func _set_volume(volume) -> void: volume_db = linear2db(volume)

func _on_death() -> void:
	var animation = $AnimationPlayer.get_animation('fadeout')
	var idx = animation.find_track(".:volume_db")
	animation.track_set_key_value(idx, 0, linear2db(Globals.bgm_volume))
	$AnimationPlayer.play("fadeout")

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	stop()
	var audiostream = load(Music.track_gameover)
	set_stream(audiostream)
	volume_db = linear2db(Globals.bgm_volume)
	play()
	Globals.game_over()

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
	if skipped: 
		playback_position = 0
		skipped = false
	seek(playback_position)
