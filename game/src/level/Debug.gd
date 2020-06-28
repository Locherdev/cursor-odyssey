extends Node2D

func _ready() -> void:
	scale = Globals.resize_screen(get_viewport().get_visible_rect().size.x)
