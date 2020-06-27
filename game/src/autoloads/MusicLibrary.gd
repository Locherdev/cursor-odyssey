extends Node

var current_track = []

var track00 = {
	"id": 0,
	"name": "Nightsky",
	"path": "res://assets/bgm/karakuri-night.ogg",
	}

var track01 = {
	"id": 1,
	"name": "Rider of the Galaxy",
	"path": "res://assets/bgm/citron.ogg",
	}
	
var tracks = []

func _ready() -> void:
	tracks.append(track00)
	tracks.append(track01)

func set_current_track(index):
	current_track = tracks[index]
	return current_track.path
