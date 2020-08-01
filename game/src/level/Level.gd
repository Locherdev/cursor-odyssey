extends Node2D

var max_num_of_asteroids: int
var max_num_of_orbs: int

func _ready() -> void:
	Globals.orb_count = 0
	_set_map_properties(Globals.difficulty)
	if Globals.connect("game_over", self, "_game_over") != OK: Globals.error_connect(self.name)
	if Globals.connect("debris_destroyed", self, "_instance_asteroid")  != OK: Globals.error_connect(self.name)
	if Globals.connect("orb_deleted", self, "_instance_orb")  != OK: Globals.error_connect(self.name)
	_initial_set_asteroids()
	_initial_set_orbs()

func _set_map_properties(diff) -> void:
	match diff:
		0: 
			max_num_of_asteroids = 15
			max_num_of_orbs = 10
		1: 
			max_num_of_asteroids = 30
			max_num_of_orbs = 6
		2: 
			max_num_of_asteroids = 45
			max_num_of_orbs = 3
		_: 
			max_num_of_asteroids = 0
			max_num_of_orbs = 0

func _initial_set_asteroids() -> void: for i in max_num_of_asteroids: _instance_asteroid()
func _initial_set_orbs() -> void: for i in max_num_of_orbs: _instance_orb()

func _instance_asteroid() -> void:
	var new_asteroid = load("res://src/debris/Debris.tscn")
	var asteroid_node = new_asteroid.instance()
	$DebrisContainer.add_child(asteroid_node)
	
func _instance_orb() -> void:
	var new_orb = load("res://src/orb/Orb.tscn")
	var orb_node = new_orb.instance()
	$OrbContainer.add_child(orb_node)

func _game_over() -> void:
	_clear_asteroids()
	_clear_orbs()

func _clear_asteroids() -> void:
	for debris in $DebrisContainer.get_children():
		$DebrisContainer.remove_child(debris)
		debris.queue_free()

func _clear_orbs() -> void:
	for orb in $OrbContainer.get_children():
		$OrbContainer.remove_child(orb)
		orb.queue_free()
