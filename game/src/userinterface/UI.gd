extends CanvasLayer

onready var trackname_label = $Control/Trackname
onready var status_log = $Control/StatusLog
onready var screen_output = $Control/ScreenOutput
onready var screen_player = $Control/ScreenOutput/ScreenPlayer
onready var ship_condition = $GameInfo/ShipCondition

var smallShake = "[shake rate=5 level=10][color=lime][center]FINE[/center][/color][/shake]"
var mediumShake = "[shake rate=15 level=10][color=yellow][center]CAUTION[/center][/color][/shake]"
var heavyShake = "[shake rate=30 level=15][color=red][center]CRITICAL[/center][/color][/shake]"

func _ready() -> void:
	if Globals.connect("trackname", self, "_change_trackname") != OK: Globals.error_connect(self)
	if Globals.connect("statuslog", self, "_append_to_statuslog") != OK: Globals.error_connect(self)
	if Globals.connect("screenOutput", self, "_output_to_screen") != OK: Globals.error_connect(self)

func _change_trackname(name): trackname_label.text = "Music: " + name

func _append_to_statuslog(text):
	status_log.append_bbcode(text)
	status_log.append_bbcode("\n")

func _output_to_screen(text):
	screen_player.stop()
	screen_output.bbcode_text = ""
	screen_output.append_bbcode("[center]"+text+"[/center]")
	screen_player.play("Text_In")
	_update_ship_condition()

func _update_ship_condition() -> void:
	if Globals.spaceship.hitpoints <= 25: ship_condition.set_bbcode(heavyShake)
	elif Globals.spaceship.hitpoints <= 50: ship_condition.set_bbcode(mediumShake)
	else: ship_condition.set_bbcode(smallShake)

func _pause_game() -> void: Globals.open_pause()
