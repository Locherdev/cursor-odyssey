extends Node

var tracks = [
	{
	"id": 0,
	"name": "Nightsky",
	"path": "res://assets/bgm/karakuri-night.ogg"
	},{
	"id": 1,
	"name": "Rider of the Galaxy",
	"path": "res://assets/bgm/citron.ogg"
	},{
	"id": 2,
	"name": "Galactic Menace",
	"path": "res://assets/bgm/bbjam.ogg" 
	},{
	"id": 3,
	"name": "Strolling Without an Aim",
	"path": "res://assets/bgm/kimidori-vinyl.ogg"
	},{
	"id": 4,
	"name": "From Behind the Asteroid",
	"path": "res://assets/bgm/mataro.ogg"
	},{
	"id": 5,
	"name": "Courageous Dive",
	"path": "res://assets/bgm/mintchoco.ogg"
	},{
	"id": 6,
	"name": "Intergalactic Space Force",
	"path": "res://assets/bgm/mu.ogg"
	},{
	"id": 7,
	"name": "Hopelessly Lost",
	"path": "res://assets/bgm/fuchsia.ogg"
	},{
	"id": 8,
	"name": "Shooting Stars",
	"path": "res://assets/bgm/melolyn.ogg"
	},{
	"id": 9,
	"name": "In the Hopes of Meeting You",
	"path": "res://assets/bgm/lemondays.ogg"
	},{
	"id": 10,
	"name": "Scared of the Unknown",
	"path": "res://assets/bgm/murasaki.ogg"
	},{
	"id": 11,
	"name": "Passing the Slow Days",
	"path": "res://assets/bgm/marbles.ogg"
	},{
	"id": 12,
	"name": "My Human Tendencies",
	"path": "res://assets/bgm/unit241.ogg"
	}
]

var current_track = []

func set_current_track(index) -> String:
	current_track = tracks[index]
	return current_track.path

func list_of_tracks(exclude_id) -> Array:
	var list = []
	for track in tracks:
		if track.id != exclude_id: list.append(track.id)
	return list
