extends Node

signal trackname(name)
signal statuslog(text)
var spaceship

func register_ship(ship):
	spaceship = ship

func track_ended():
	print("Emit track ended: ",Music.current_track.name)
	emit_signal("trackname", Music.current_track.name)

func append_to_statuslog(text):
	emit_signal("statuslog", text)
