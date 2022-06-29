extends Node2D

export var world_size: Vector2 = Vector2(10000, 10000)
onready var ship = $Spaceship

func _ready():
	ship.set_camera_limits(world_size)
	ship.position = Vector2(randi() % int(world_size.x), randi() % int(world_size.y))

func _process(delta):
	if Input.is_action_just_released("debug"):
		for i in 10: $ObjectContainer.add_child(load("res://src/debris/Debris.tscn").instance())
	$InterfaceLayer/debugLabel.text = str(ship.position)
