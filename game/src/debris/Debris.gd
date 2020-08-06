extends KinematicBody2D

const oof_distance:int = 1400

var rotation_speed:float = float(rand_range(-2,2))
var debris_scale:float = float(rand_range(0.1,0.5))
var propulsion_speed:int = int(rand_range(10,150))
var propulsion

func _ready() -> void: 
	scale = Vector2(debris_scale, debris_scale)
	position = _randomize_position(Globals.spaceship.position)
	if Globals.difficulty > 0: propulsion = _calculate_trajectory(Globals.spaceship.position)
	if Globals.difficulty > 1: propulsion_speed *= 2

func _physics_process(delta: float) -> void:
	rotate(rotation_speed*delta)
	if Globals.difficulty > 0: var _velocity = move_and_slide(propulsion, Vector2.UP)
	if _out_of_focus(): _destroy()

func _calculate_trajectory(ship_pos):
	var rand_x = int(rand_range(ship_pos.x - 400, ship_pos.x + 400))
	var rand_y = int(rand_range(ship_pos.y - 400, ship_pos.y + 400))
	var trajectory = Vector2(rand_x, rand_y) - position
	return trajectory.normalized() * Vector2(propulsion_speed,propulsion_speed)

func _randomize_position(pos) -> Vector2:
	randomize()
	var rand_x = int(rand_range(-1000, 1000))
	var rand_y
	if rand_x <= -600 || rand_x >= 600: 
		rand_y = int(rand_range(-1000, 1000))
	else:
		rand_y = int(rand_range(600, 1000))
		rand_y = [rand_y, rand_y * -1]
		rand_y = rand_y[randi() % rand_y.size()]
	return Vector2(rand_x + pos.x,rand_y + pos.y)
	
func _destroy() -> void:
	Globals.debris_destroyed()
	queue_free()

func _collision(body: Node) -> void:
	if body == Globals.spaceship:
		collision_mask = 0
		$AnimationPlayer.play("Explosion")
		Music.play_audio($Soundeffects, Music.sfx_sounds_total[0].path)
		Globals.spaceship.receive_damage(_damage_calculation())
	elif body != self:
		$AnimationPlayer.play("Explosion")
		Music.play_audio($Soundeffects, Music.sfx_sounds_total[0].path)

func _deathAnimation_end(_anim_name: String) -> void: _destroy()

func _damage_calculation() -> int: 
	var damage = int((debris_scale * 100) / 2)
	return damage * 1.5 if Globals.difficulty > 1 else damage

func _out_of_focus() -> bool:
	var distance = get_global_position().distance_to(Globals.spaceship.get_global_position())
	return true if distance > oof_distance else false
