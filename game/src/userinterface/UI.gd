extends CanvasLayer

onready var screen_output = $ScreenOutput
onready var screen_player = $ScreenOutput/ScreenPlayer
onready var ship_condition = $GameInfo/ShipCondition
onready var trackname_label = $GameInfo/Trackname
onready var orb_label = $GameInfo/ColorRect/HBoxContainer/OrbCount

func _ready() -> void:
	if Globals.connect("trackname", self, "_change_trackname") != OK: Globals.error_connect(self)
	if Globals.connect("screenOutput", self, "_output_to_screen") != OK: Globals.error_connect(self)
	if Globals.connect("get_orb", self, "_update_orb_counter") != OK: Globals.error_connect(self)
	_update_orb_counter()

func _change_trackname(name): trackname_label.text = "Music: " + name

func _output_to_screen(text):
	screen_player.stop()
	screen_output.bbcode_text = ""
	screen_output.append_bbcode("[center]"+text+"[/center]")
	screen_player.play("Text_In")
	_update_ship_condition()

func _update_ship_condition() -> void:
	if Globals.spaceship.hitpoints <= 33: ship_condition.set_bbcode(Globals.heavyShake)
	elif Globals.spaceship.hitpoints <= 66: ship_condition.set_bbcode(Globals.mediumShake)
	else: ship_condition.set_bbcode(Globals.smallShake)

func _pause_game() -> void: Globals.open_pause()

func _update_orb_counter(total_orbs:int = 0) -> void:
	orb_label.text = str(total_orbs) + "x"
