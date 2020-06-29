extends CanvasLayer

onready var trackname_label = $Trackname
onready var status_log = $Control/StatusLog

func _ready() -> void:
	Globals.connect("trackname", self, "_change_trackname")
	Globals.connect("statuslog", self, "_append_to_statuslog")

func _process(delta: float) -> void:
	_debug()

func _change_trackname(name):
	trackname_label.text = "Music: " + name	

func _append_to_statuslog(text):
	status_log.append_bbcode(text)
	status_log.append_bbcode("\n")
	#status_log.text += "\n" + text

### Debug Output Functions ###
func _debug():
	$Debug/Debug_position.text = "Position: ("+ str(int(Globals.spaceship.position.x)) + "/" + str(int(Globals.spaceship.position.y))+")"
	$Debug/Debug_velocity.text = "Velocity: "+ str(Globals.spaceship.vel.floor()) + "\nDistance: " + str(Globals.spaceship.distance)
