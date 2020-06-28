extends Node

var current_track = []

var track00 = {
	"id": 0,
	"name": "Nightsky",
	"path": "res://assets/bgm/karakuri-night.ogg"
	}

var track01 = {
	"id": 1,
	"name": "Rider of the Galaxy",
	"path": "res://assets/bgm/citron.ogg"
	}

var track02 = {
	"id": 2,
	"name": "Galactic Menace",
	"path": "res://assets/bgm/bbjam.ogg" 
	}

var track03 = {
	"id": 3,
	"name": "Strolling without an Aim",
	"path": "res://assets/bgm/kimidori-vinyl.ogg"
	}

var track04 = {
	"id": 4,
	"name": "From behind the Asteroid",
	"path": "res://assets/bgm/mataro.ogg"
	}

var track05 = {
	"id": 5,
	"name": "Courageous Dive",
	"path": "res://assets/bgm/mintchoco.ogg"
	}

var track06 = {
	"id": 6,
	"name": "Intergalactic Space Force",
	"path": "res://assets/bgm/mu.ogg"
	}

var track07 = {
	"id": 7,
	"name": "Hopelessly Lost",
	"path": "res://assets/bgm/fuchsia.ogg"
	}
	
var tracks = []

func _ready() -> void:
	tracks.append(track00)
	tracks.append(track01)
	tracks.append(track02)
	tracks.append(track03)
	tracks.append(track04)
	tracks.append(track05)
	tracks.append(track06)
	tracks.append(track07)

func set_current_track(index):
	current_track = tracks[index]
	return current_track.path
