extends KinematicBody2D

var rotation_speed = float(rand_range(-2,2))

func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name == 'Spaceship'):
		$Area2D.visible = false
		$AnimationPlayer.play("Explosion")
		Globals.append_to_statuslog(StatusMsg.game_collisionDebris)
		Globals.spaceship.receive_damage()

func _process(delta: float) -> void:
	rotate(rotation_speed*delta)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()
