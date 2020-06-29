extends KinematicBody2D

var rotation_speed = float(rand_range(-2,2))

func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name == 'Spaceship'):
		Globals.append_to_statuslog("- Spaceship crashed into debris.")
		queue_free()

func _process(delta: float) -> void:
	rotate(rotation_speed*delta)
