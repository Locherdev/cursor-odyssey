extends Control

var gadget_slots: Dictionary

func _ready():
	gadget_slots = { "top": $Top, "bottom": $Bottom, "left": $Left, "right": $Right }

func calibrate_rotation():
	$Top.rect_rotation = 0
	$Right.rect_rotation = 90
	$Bottom.rect_rotation = 180
	$Left.rect_rotation = 270
