extends KinematicBody2D

func _ready() -> void:
	pass # Replace with function body.

func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name == 'Spaceship'):
		Globals.append_to_statuslog("- Spaceship crashed into debris.")
		queue_free()
