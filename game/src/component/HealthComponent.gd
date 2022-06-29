extends Node2D

signal health_changed(health)
signal maxhealth_increased(maxhealth)

export var health: int = 100
export var maxhealth: int = 100

func adjust_health(value) -> int:
	print("HealthContainer: Adjust health")
	health += value
	health = clamp(health, 0, maxhealth)
	emit_signal("health_changed", health)
	return health

func increase_maxhealth(value):
	maxhealth += value
	emit_signal("maxhealth_increased", maxhealth)
