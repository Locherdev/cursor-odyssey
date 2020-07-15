extends KinematicBody2D

export var max_move_speed = 250
export var min_move_speed = 50
export var stop_distance = 250
var vel: Vector2
var distance
var hitpoints = 4

func _ready() -> void:
	Globals.register_ship(self)
	$Effect.visible = false

func _process(_delta: float) -> void:
	_look_at_mouse()
	_move_to_mouse()
	
func _look_at_mouse():
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
func _move_to_mouse():
	distance = abs(floor(get_local_mouse_position().y))
	if position.distance_to(Vector2(abs(get_local_mouse_position().x),abs(get_local_mouse_position().y))) > stop_distance:
		var direction = get_global_mouse_position() - position
		var normalized_direction = direction.normalized()
		var direction_distance = direction.length()
		vel = move_and_slide(normalized_direction * max(min_move_speed, min(max_move_speed, direction_distance)))

# Collision #
func receive_damage():
	hitpoints -= 1
	match hitpoints:
		3:
			Globals.output_to_screen(StatusMsg.screen_smallDMG)
		2:
			Globals.output_to_screen(StatusMsg.screen_moderateDMG)
		1:
			Globals.output_to_screen(StatusMsg.screen_critialDMG)
		0:
			Globals.output_to_screen(StatusMsg.screen_deathDMG)
			$Effect.visible = true
			$AnimationPlayer.play("Explosion")
			_play_sound()
			Globals.death()
			set_process(false)

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	$Effect.visible = false

func _play_sound():
	var soundstream = load(Music.sounds_total[1].path)
	$Soundeffects.set_stream(soundstream)
	$Soundeffects.volume_db = linear2db(Globals.game_volume)
	$Soundeffects.play()
