extends CanvasLayer

onready var trackname_label = $Trackname
onready var status_log = $Statusbar/StatusLog

func _ready() -> void:
	print("connected now")
	Globals.connect("trackname", self, "_change_trackname")
	Globals.connect("statuslog", self, "_append_to_statuslog")

func _process(delta: float) -> void:
	_debug_spaceship_position()

func _change_trackname(name):
	print("changed name to ",name)
	trackname_label.text = "Music: " + name	

func _append_to_statuslog(text):
	status_log.text += "\n" + text

### Debug Functions ###
func _debug_spaceship_position():
	$Debug_position.text = "X: " + str(int(Globals.spaceship.position.x)) + "\nY: " + str(int(Globals.spaceship.position.y))
