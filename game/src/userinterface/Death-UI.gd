extends CanvasLayer

onready var highscore_news = [
	$MainWindow/Scorelist/One_New,
	$MainWindow/Scorelist/Two_New,
	$MainWindow/Scorelist/Three_New,
	$MainWindow/Scorelist/Four_New,
	$MainWindow/Scorelist/Five_New
]

onready var highscore_names = [
	$MainWindow/Scorelist/One_Name,
	$MainWindow/Scorelist/Two_Name,
	$MainWindow/Scorelist/Three_Name,
	$MainWindow/Scorelist/Four_Name,
	$MainWindow/Scorelist/Five_Name
]

onready var highscore_sets = [
	$MainWindow/Scorelist/One_Set,
	$MainWindow/Scorelist/Two_Set,
	$MainWindow/Scorelist/Three_Set,
	$MainWindow/Scorelist/Four_Set,
	$MainWindow/Scorelist/Five_Set,
]

onready var highscore_orbs = [
	$MainWindow/Scorelist/One_Score,
	$MainWindow/Scorelist/Two_Score,
	$MainWindow/Scorelist/Three_Score,
	$MainWindow/Scorelist/Four_Score,
	$MainWindow/Scorelist/Five_Score,
]

onready var enter_name_label = $MainWindow/Scorelist/EnterName
onready var set_name_button = $MainWindow/Scorelist/Set_Button

func _highscores_initialize(current_score) -> void:
	var index = Highscores.evaluate_new_score(current_score)
	Highscores.update_highscores(highscore_names, highscore_orbs)
	if index != -1: print("New Highscore!")
	else: _show_bad_score(current_score)
	$MainWindow.visible = true
	
func _show_bad_score(current_score) -> void:
	$MainWindow/Bad_Userscore/Bad_Score.text = str(current_score)
	$MainWindow/Bad_Userscore.visible = true
func _update_highscores() -> void: pass
	
func _ready() -> void: if Globals.connect("death", self, "_on_death") != OK: Globals.error_connect(self.name)
func _on_death() -> void: $AnimationPlayer.play("black")
func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void: _highscores_initialize(Globals.orb_count)
func _on_Button_pressed() -> void: 
	_update_highscores()
	var _success = get_tree().change_scene("res://src/level/Titlescreen.tscn")
