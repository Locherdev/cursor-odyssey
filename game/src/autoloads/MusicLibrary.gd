extends Node

var tracks_early = [
	{
	"id": 0,
	"name": "Strolling Without an Aim",
	"path": "res://assets/bgm/kimidori-vinyl.ogg"
	},{
	"id": 1,
	"name": "Courageous Dive",
	"path": "res://assets/bgm/mintchoco.ogg"
	},{
	"id": 2,
	"name": "Intergalactic Space Force",
	"path": "res://assets/bgm/mu.ogg"
	},{
	"id": 3,
	"name": "Rider of the Galaxy",
	"path": "res://assets/bgm/citron.ogg"
	},{
	"id": 4,
	"name": "Walking Barefoot on Stardust",
	"path": "res://assets/bgm/sunshower.ogg"
	}
]

var tracks_mid = [
	{
	"id": 0,
	"name": "Hopelessly Lost",
	"path": "res://assets/bgm/fuchsia.ogg"
	},{
	"id": 1,
	"name": "Nightsky",
	"path": "res://assets/bgm/karakuri-night.ogg"
	},{
	"id": 2,
	"name": "In the Hopes of Meeting You",
	"path": "res://assets/bgm/lemondays.ogg"
	},{
	"id": 3,
	"name": "Passing the Slow Days",
	"path": "res://assets/bgm/marbles.ogg"
	},{
	"id": 4,
	"name": "Shooting Stars",
	"path": "res://assets/bgm/melolyn.ogg"
	},{
	"id": 5,
	"name": "Spending Time to Ponder",
	"path": "res://assets/bgm/godot.ogg"
	}
]

var tracks_late = [
	{
	"id": 0,
	"name": "Galactic Menace",
	"path": "res://assets/bgm/bbjam.ogg" 
	},{
	"id": 1,
	"name": "From Behind the Asteroid",
	"path": "res://assets/bgm/mataro.ogg"
	},{
	"id": 2,
	"name": "Scared of the Unknown",
	"path": "res://assets/bgm/murasaki.ogg"
	},{
	"id": 3,
	"name": "Blooming under Pressure",
	"path": "res://assets/bgm/crescent.ogg"
	},{
	"id": 4,
	"name": "Onwards, my Odyssey!",
	"path": "res://assets/bgm/unit241.ogg"
	}
]

var tracks_total = [tracks_early,tracks_mid,tracks_late]
var track_title = "res://assets/bgm/frankenstein.ogg"
var track_options = "res://assets/bgm/pineapple.ogg"
var track_gameover = "res://assets/bgm/kowloon.ogg"
var track_credits = "res://assets/bgm/plumrain.ogg"
var current_track = []

### Sound Effects ###
var sounds_total = [
	{
	"id": 0,
	"name": "Explosion Debris",
	"path": "res://assets/sfx/explosion_debris.wav"
	},{
	"id": 1,
	"name": "Explosion Ship",
	"path": "res://assets/sfx/Explosion_ship.wav"
	}
]

func set_current_track(lib_id, index) -> String:
	match lib_id:
		0: current_track = tracks_early[index]
		1: current_track = tracks_mid[index]
		2: current_track = tracks_late[index]
		_: current_track = tracks_total[index]
	return current_track.path

func list_of_tracks(lib_id, exclude_id) -> Array:
	var list = []
	var tracks = []
	match lib_id:
		0: tracks = tracks_early
		1: tracks = tracks_mid
		2: tracks = tracks_late
		_: tracks = tracks_total
	for track in tracks: if track.id != exclude_id: list.append(track.id)
	return list
