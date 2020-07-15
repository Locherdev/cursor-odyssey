extends KinematicBody2D

var rotation_speed = float(rand_range(-2,2))
var debris_scale = float(rand_range(0.1,0.5))

func _ready() -> void: scale = Vector2(debris_scale, debris_scale)

func _destroy() -> void:
	Globals.debris_destroyed()
	queue_free()

func _collision(body: Node) -> void:
	match body.get_filename():
		"res://src/spaceship/Spaceship.tscn":
			$Personal_Space/CollisionShape2D.disabled = true
			$AnimationPlayer.play("Explosion")
			_play_sound()
			Globals.append_to_statuslog(StatusMsg.game_collisionDebris)
			Globals.spaceship.receive_damage()
		"res://src/debris/Debris.tscn":
			if body != self:
				$Personal_Space/CollisionShape2D.disabled = true
				$AnimationPlayer.play("Explosion")

func _process(delta: float) -> void: 
	rotate(rotation_speed*delta)
	if _out_of_focus(): _destroy()

func _out_of_focus() -> bool:
	var distance = get_global_position().distance_to(Globals.spaceship.get_global_position())
	if distance > 1400: return true
	#var spaceship_pos = Globals.spaceship.position
	#var x_diff = abs(abs(position.x) - abs(spaceship_pos.x))
	#var y_diff = abs(abs(position.y) - abs(spaceship_pos.y))
	#if x_diff > 1000 || y_diff > 1000: return true
	else: return false

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void: _destroy()

func _play_sound():
	var soundstream = load(Music.sounds_total[0].path)
	$Soundeffects.set_stream(soundstream)
	$Soundeffects.volume_db = linear2db(Globals.game_volume)
	$Soundeffects.play()
