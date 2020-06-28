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
	status_log.text += "\n" + text

### Debug Functions ###
func _debug():
	if (get_viewport().get_visible_rect().size.x < 500):
		Globals.screen_mode = "s"
	elif (get_viewport().get_visible_rect().size.x < 1000):
		Globals.screen_mode = "m"
	else:
		Globals.screen_mode = "l"
	$Debug/Debug_position.text = "Position: ("+ str(int(Globals.spaceship.position.x)) + "/" + str(int(Globals.spaceship.position.y))+")"
	$Debug/Debug_velocity.text = "Velocity: "+ str(Globals.spaceship.vel.floor()) + "\nScreenmode: " + Globals.screen_mode + "\nScreensize: " + str(get_viewport().get_visible_rect().size.x) + "/" + str(get_viewport().get_visible_rect().size.y) + "\nDistance: " + str(Globals.spaceship.distance)
