extends CanvasLayer

onready var trackname_label = $Control/Trackname
onready var status_log = $Control/StatusLog
onready var screen_output = $Control/ScreenOutput
onready var screen_player = $Control/ScreenOutput/ScreenPlayer

func _ready() -> void:
	Globals.connect("trackname", self, "_change_trackname")
	Globals.connect("statuslog", self, "_append_to_statuslog")
	Globals.connect("screenOutput", self, "_output_to_screen")

func _process(delta: float) -> void:
	_debug()

func _change_trackname(name):
	trackname_label.text = "Music: " + name

func _append_to_statuslog(text):
	status_log.append_bbcode(text)
	status_log.append_bbcode("\n")
	#status_log.text += "\n" + text

func _output_to_screen(text):
	screen_player.stop()
	screen_output.bbcode_text = ""
	screen_output.append_bbcode("[center]"+text+"[/center]")
	screen_player.play("Text_In")

### Debug Output Functions ###
func _debug():
	$Debug/Debug_position.text = "Position: ("+ str(int(Globals.spaceship.position.x)) + "/" + str(int(Globals.spaceship.position.y))+")"
	$Debug/Debug_velocity.text = "Velocity: "+ str(Globals.spaceship.vel.floor()) + "\nDistance: " + str(Globals.spaceship.distance)


