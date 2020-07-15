extends Node2D

export(int) var max_num_of_asteroids

func _ready() -> void:
	if Globals.connect("game_over", self, "_clear_asteroids") != OK: Globals.error_connect(self)
	if Globals.connect("debris_destroyed", self, "_instance_asteroid")  != OK: Globals.error_connect(self)
	_initial_set_asteroids()

func _initial_set_asteroids() -> void: for i in max_num_of_asteroids: _instance_asteroid()

func _instance_asteroid() -> void:
	var new_asteroid = load("res://src/debris/Debris.tscn")
	var asteroid_node = new_asteroid.instance()
	$DebrisContainer.add_child(asteroid_node)

func _clear_asteroids() -> void:
	for debris in $DebrisContainer.get_children():
		$DebrisContainer.remove_child(debris)
		debris.queue_free()
