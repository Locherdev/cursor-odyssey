extends AudioStreamPlayer

signal track_ended()

func _ready() -> void:
	connect("finished", self, "_get_next_track")
	_get_next_track()

func _get_next_track() -> void:
	print("get next track")
	var rand_number = randi() % Music.tracks.size()
	var audiostream = load(Music.set_current_track(rand_number))
	set_stream(audiostream)
	play()
	Globals.track_ended()

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("debug")):
		Globals.append_to_statuslog("- DEBUG: Skipped Song")
		_get_next_track()
