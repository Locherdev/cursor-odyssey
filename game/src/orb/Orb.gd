extends AnimatedSprite

func _ready() -> void: position = _randomize_position(Globals.spaceship.position)

func _physics_process(delta: float) -> void: if _out_of_focus(): _destroy()
	
func _randomize_position(pos) -> Vector2:
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

func _out_of_focus() -> bool:
	var distance = get_global_position().distance_to(Globals.spaceship.get_global_position())
	if distance > 1400: return true
	else: return false

func _get_item(body: Node) -> void:
	if body.name == "Spaceship":
		Globals.get_orb()
		_play_sound()
		$AnimationPlayer.play("Destroy")
	elif body.name == "Orb": 
		if body != self: _destroy()

func _play_sound():
	var soundstream = load(Music.sounds_total[2].path)
	$Soundeffects.set_stream(soundstream)
	$Soundeffects.volume_db = linear2db(Globals.game_volume)
	$Soundeffects.play()

func _destroy() -> void:
	Globals.orb_deleted()
	queue_free()

func _on_pickup_animation_end(_anim_name: String) -> void: _destroy()
