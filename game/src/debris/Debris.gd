extends KinematicBody2D

func _ready() -> void:
	pass # Replace with function body.

func _on_Area2D_body_entered(body: Node) -> void:
	if(body.name == 'Spaceship'):
		print("Crashed into Spaceship!")
		queue_free()
