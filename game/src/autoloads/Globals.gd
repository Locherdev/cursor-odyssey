extends Node

signal screenOutput(text)

signal trackname(name)
signal set_bgm_volume(value)
signal set_sfx_volume(value)
signal skip_to_next_track()

signal death()
signal open_pause()
signal open_highscores()
signal pause_game()
signal resume_game()
signal debris_destroyed()
signal orb_deleted()
signal get_orb(orb_count)
signal game_over()

### Screen Output ###
const screen_smallDMG = "[shake rate=5 level=10][color=lime]Small damage to ship's hull detected[/color][/shake]"
const screen_moderateDMG = "[shake rate=5 level=10][color=yellow]Moderate damage to ship's hull detected[/color][/shake]"
const screen_criticalDMG = "[shake rate=5 level=10][color=red]Critical damage to ship's hull detected[/color][/shake]"
const screen_deathDMG = "[shake rate=5 level=10][color=red]Unreparable damage to ship. Please evacuate.[/color][/shake]"

### Ship Condition ###
const smallShake = "[shake rate=5 level=10][color=lime][center]FINE[/center][/color][/shake]"
const mediumShake = "[shake rate=15 level=10][color=yellow][center]CAUTION[/center][/color][/shake]"
const heavyShake = "[shake rate=30 level=15][color=red][center]CRITICAL[/center][/color][/shake]"

var spaceship
var bgm_volume: float = 0.5
var sfx_volume: float = 0.5
var disable_uiCancel: bool = false
var orb_count: int = 0
var difficulty: int  = 0 #easy0, normal1, hard2

func output_to_screen(text) -> void: emit_signal("screenOutput", text)

func change_trackname() -> void: emit_signal("trackname", Music.current_track.name)
func set_bgm_volume(value) -> void: 
	Globals.bgm_volume = value
	emit_signal("set_bgm_volume", value)
func set_sfx_volume(value) -> void: 
	Globals.sfx_volume = value
	emit_signal("set_sfx_volume", value)
func skip_to_next_track() -> void: emit_signal("skip_to_next_track")

func register_ship(ship) -> void: spaceship = ship
func open_pause() -> void: emit_signal("open_pause")
func open_highscores() -> void: emit_signal("open_highscores")
func pause(state) -> void:
	if spaceship: spaceship.visible = not state
	if state: emit_signal("pause_game")
	else: emit_signal("resume_game")

func death() -> void: emit_signal("death")
func debris_destroyed() -> void: emit_signal("debris_destroyed")
func orb_deleted() -> void: emit_signal("orb_deleted")
func get_orb() -> void: 
	Globals.orb_count += 1
	emit_signal("get_orb", Globals.orb_count)
	
func game_over() -> void: emit_signal("game_over")

func error_connect(args) -> void: print(args, " could not be connected!")
