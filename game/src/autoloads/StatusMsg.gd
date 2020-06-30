extends Node

var debug_skipSong = "[color=yellow]- DEBUG: Skip current track[/color]"

var game_collisionDebris = "- Spaceship crashed into debris."

var system_gamePaused = "[color=red]- SYSTEM: Game paused.[/color]"
var system_gameResumed = "[color=red]- SYSTEM: Game resumed.[/color]"
func system_volume(vol) -> String:
	return "[color=red]- SYSTEM: Game volume [" + vol + "/1.0][/color]"
