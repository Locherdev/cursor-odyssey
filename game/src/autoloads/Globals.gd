extends Node

signal statuslog(text)
signal screenOutput(text)

signal trackname(name)
signal set_music_volume(value)
signal skip_to_next_track()

signal death()
signal open_pause()
signal pause_game()
signal resume_game()

var spaceship
var game_volume = 0.5
var disable_uiCancel = false

func append_to_statuslog(text): emit_signal("statuslog", text)
func output_to_screen(text): emit_signal("screenOutput", text)

func change_trackname(): emit_signal("trackname", Music.current_track.name)
func set_music_volume(value): emit_signal("set_music_volume", value)
func skip_to_next_track(): emit_signal("skip_to_next_track")

func register_ship(ship): spaceship = ship
func open_pause(): emit_signal("open_pause")
func pause(state):
	spaceship.visible = not state
	if state:
		append_to_statuslog(StatusMsg.system_gamePaused)
		emit_signal("pause_game")
	else:
		append_to_statuslog(StatusMsg.system_gameResumed)
		emit_signal("resume_game")

func death(): emit_signal("death")

func error_connect(args): print(args, " could not be connected!")
