extends HBoxContainer

var maxhealth: int = 100

func _on_health_changed(health):
	var percentage = float(health) / float(maxhealth)
	$TextureProgress.value = health
	$ColorRect/Number.text = "%s / %s" % [health, maxhealth]
	$TextureProgress.set_tint_progress(Color(1, percentage, percentage, 1))
	_change_condition(percentage)

func _on_maxhealth_increased(max_hp):
	maxhealth = max_hp
	$TextureProgress.max_value = maxhealth

func _change_condition(percentage: float):
	if percentage < 0.3:
		print("Critical condition")
	elif percentage < 0.6:
		print("Moderate condition")
	else:
		print("Good condition")
