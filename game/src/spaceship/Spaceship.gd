extends KinematicBody2D

onready var engine_fire = $ship/enginefire

export var max_move_speed = 250
export var min_move_speed = 50
export var stop_distance = 50
var velocity: Vector2

onready var healthComponent = $HealthComponent

func _ready() -> void:
	Globals.register_ship(self)

func _physics_process(_delta: float) -> void:
	_look_at_mouse()
	_move_to_mouse()

func _look_at_mouse():
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
func _move_to_mouse():
	_set_enginefire(position.distance_to(get_global_mouse_position()) - stop_distance)
	if position.distance_to(get_global_mouse_position()) > stop_distance:
		var direction = get_global_mouse_position() - position
		var normalized_direction = direction.normalized()
		var direction_distance = direction.length()
		velocity = move_and_slide(normalized_direction * max(min_move_speed, min(max_move_speed, direction_distance)))

func _set_enginefire(power) -> void: engine_fire.visible = false if power < 0 else true

# Collision #
func assess_ship_condition(hp):
	if hp <= 0: 	explode()
	elif hp <= 33: 	Globals.output_to_screen(Globals.screen_criticalDMG)
	elif hp <= 66: 	Globals.output_to_screen(Globals.screen_moderateDMG)
	else:			Globals.output_to_screen(Globals.screen_smallDMG)

func change_health(value: int):
	var updated_health = healthComponent.adjust_health(value)
	assess_ship_condition(updated_health)

func get_health() -> int:
	return healthComponent.health

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void: $Effect.visible = false

func explode():
	Globals.output_to_screen(Globals.screen_deathDMG)
	$Effect.visible = true
	$AnimationPlayer.play("Explosion")
	Music.play_audio($Soundeffects, Music.sfx_sounds_total[1].path)
	Globals.death()
	set_physics_process(false)

func set_camera_limits(limits: Vector2):
	$Camera2D.limit_left = 0
	$Camera2D.limit_top = 0
	$Camera2D.limit_right = limits.x
	$Camera2D.limit_bottom = limits.y
