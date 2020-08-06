extends Node2D

var max_num_of_asteroids: int
var max_num_of_orbs: int

func _ready() -> void:
	if Globals.connect("game_over", self, "_game_over") != OK: Globals.error_connect(self.name)
	if Globals.connect("debris_destroyed", self, "_create_new_asteroid")  != OK: Globals.error_connect(self.name)
	if Globals.connect("orb_deleted", self, "_create_new_orb")  != OK: Globals.error_connect(self.name)
	_setup_game()

func _setup_game() -> void:
	Globals.orb_count = 0
	Globals.disable_uiCancel = false
	_setup_properties(Globals.difficulty)
	_setup_asteroids()
	_setup_orbs()
	
func _setup_properties(difficulty: int) -> void:
	match difficulty:
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

func _setup_asteroids() -> void: for i in max_num_of_asteroids: _create_new_asteroid()
func _setup_orbs() -> void: for i in max_num_of_orbs: _create_new_orb()
func _create_new_asteroid() -> void: $DebrisContainer.add_child(load("res://src/debris/Debris.tscn").instance())
func _create_new_orb() -> void: $OrbContainer.add_child(load("res://src/orb/Orb.tscn").instance())

func _game_over() -> void:
	$Background/Options.queue_free()
	Globals.disable_uiCancel = true
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

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		pass
