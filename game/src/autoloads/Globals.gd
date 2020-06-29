extends Node

signal trackname(name)
signal statuslog(text)
signal pause_game()
signal resume_game()
signal set_music_volume(vol, flag)
signal death()

var spaceship
var game_volume = 0.5

func register_ship(ship):
	spaceship = ship

func change_trackname():
	emit_signal("trackname", Music.current_track.name)

func append_to_statuslog(text):
	emit_signal("statuslog", text)

func pause(state):
	spaceship.visible = not state
	if state:
		append_to_statuslog("[color=red]- SYSTEM: Game paused.[/color]")
		emit_signal("pause_game")
	else:
		append_to_statuslog("[color=red]- SYSTEM: Game resumed.[/color]")
		emit_signal("resume_game")

func set_music_volume(flag):
	emit_signal("set_music_volume", game_volume, flag)

func death():
	emit_signal("death")
