extends Node

### Statusbar Output ###
var game_collisionDebris = "- Spaceship crashed into debris."

var system_gamePaused = "[color=red]- SYSTEM: Game paused.[/color]"
var system_gameResumed = "[color=red]- SYSTEM: Game resumed.[/color]"
func system_volume(vol) -> String:
	return "[color=red]- SYSTEM: Game volume [" + vol + "/1.0][/color]"

### Screen Output ###
var screen_smallDMG = "[shake rate=5 level=10][color=lime]Small damage to ship's hull detected[/color][/shake]"
var screen_moderateDMG = "[shake rate=5 level=10][color=yellow]Moderate damage to ship's hull detected[/color][/shake]"
var screen_critialDMG = "[shake rate=5 level=10][color=red]Critical damage to ship's hull detected[/color][/shake]"
var screen_deathDMG = "[shake rate=5 level=10][color=red]Unreparable damage to ship. Please evacuate.[/color][/shake]"
