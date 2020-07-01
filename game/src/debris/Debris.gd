extends KinematicBody2D

var rotation_speed = float(rand_range(-2,2))

func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name == 'Spaceship'):
		$Area2D.visible = false
		$AnimationPlayer.play("Explosion")
		_play_sound()
		Globals.append_to_statuslog(StatusMsg.game_collisionDebris)
		Globals.spaceship.receive_damage()

func _process(delta: float) -> void:
	rotate(rotation_speed*delta)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()

func _play_sound():
	var soundstream = load(Music.sounds_total[0].path)
	$Soundeffects.set_stream(soundstream)
	$Soundeffects.volume_db = linear2db(Globals.game_volume)
	$Soundeffects.play()
