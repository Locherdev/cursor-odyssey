extends Node2D

export(int) var max_num_of_asteroids

func _ready() -> void:
	Globals.connect("debris_destroyed", self, "_set_asteroid")
	_initial_set_asteroids()

func _initial_set_asteroids() -> void: for i in max_num_of_asteroids: _set_asteroid()

func _set_asteroid() -> void:
	var new_asteroid = load("res://src/debris/Debris.tscn")
	var asteroid_node = new_asteroid.instance()
	asteroid_node.position = _random(Globals.spaceship.position)
	$DebrisContainer.add_child(asteroid_node)

func _random(pos) -> Vector2:
	randomize()
	var rand_x = int(rand_range(-1000, 1000))
	var rand_y
	if rand_x <= -600 || rand_x >= 600: 
		rand_y = int(rand_range(-1000, 1000))
	else:
		rand_y = int(rand_range(600, 1000))
		rand_y = [rand_y, rand_y * -1]
		rand_y = rand_y[randi() % rand_y.size()]
	return Vector2(rand_x + pos.x,rand_y + pos.y)
