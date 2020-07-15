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
signal debris_destroyed()
signal game_over()

var spaceship
var game_volume = 0.5
var disable_uiCancel = false
var difficulty = 0 #easy0, normal1, hard2

func append_to_statuslog(text) -> void: emit_signal("statuslog", text)
func output_to_screen(text) -> void: emit_signal("screenOutput", text)

func change_trackname() -> void: emit_signal("trackname", Music.current_track.name)
func set_music_volume(value) -> void: emit_signal("set_music_volume", value)
func skip_to_next_track() -> void: emit_signal("skip_to_next_track")

func register_ship(ship) -> void: spaceship = ship
func open_pause() -> void: emit_signal("open_pause")
func pause(state) -> void:
	spaceship.visible = not state
	if state:
		append_to_statuslog(StatusMsg.system_gamePaused)
		emit_signal("pause_game")
	else:
		append_to_statuslog(StatusMsg.system_gameResumed)
		emit_signal("resume_game")

func death() -> void: emit_signal("death")
func debris_destroyed() -> void: emit_signal("debris_destroyed")
func game_over() -> void: emit_signal("game_over")

func error_connect(args) -> void: print(args, " could not be connected!")
