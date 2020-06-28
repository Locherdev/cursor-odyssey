extends Node

signal trackname(name)
signal statuslog(text)
signal pause_game()
signal resume_game()

var spaceship
var screen_mode

func register_ship(ship):
	spaceship = ship

func track_ended():
	emit_signal("trackname", Music.current_track.name)

func append_to_statuslog(text):
	emit_signal("statuslog", text)

func resize_screen(size):
	if (size < 500):
		screen_mode = "s"
		return Vector2(0.3,0.3)
	elif (size < 1000):
		screen_mode = "m"
		return Vector2(0.6,0.6)
	else:
		screen_mode = "l"
		return Vector2(1.0,1.0)

func pause(state):
	if state:
		spaceship.visible = not state
		emit_signal("pause_game")
	else:
		spaceship.visible = not state
		emit_signal("resume_game")
