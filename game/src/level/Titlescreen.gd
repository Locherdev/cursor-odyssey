extends Node2D

func _ready() -> void: 
	if Globals.connect("set_bgm_volume", self, "_set_volume") != OK: Globals.error_connect(self.name)
	$AudioStreamPlayer.volume_db = linear2db(Globals.bgm_volume)
	Globals.spaceship = null
func _pause_game() -> void: Globals.open_pause()
func _set_volume(volume) -> void: $AudioStreamPlayer.volume_db = linear2db(volume)
