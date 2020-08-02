extends CanvasLayer

onready var highscore_news = [
	$MainWindow/Scorelist/One_New,
	$MainWindow/Scorelist/Two_New,
	$MainWindow/Scorelist/Three_New,
	$MainWindow/Scorelist/Four_New,
	$MainWindow/Scorelist/Five_New
]

onready var highscore_numbering = [
	$MainWindow/Scorelist/One_Numbering,
	$MainWindow/Scorelist/Two_Numbering,
	$MainWindow/Scorelist/Three_Numbering,
	$MainWindow/Scorelist/Four_Numbering,
	$MainWindow/Scorelist/Five_Numbering,
]

onready var highscore_names = [
	$MainWindow/Scorelist/One_Name,
	$MainWindow/Scorelist/Two_Name,
	$MainWindow/Scorelist/Three_Name,
	$MainWindow/Scorelist/Four_Name,
	$MainWindow/Scorelist/Five_Name
]

onready var highscore_diff = [
	$MainWindow/Scorelist/One_Difficulty,
	$MainWindow/Scorelist/Two_Difficulty,
	$MainWindow/Scorelist/Three_Difficulty,
	$MainWindow/Scorelist/Four_Difficulty,
	$MainWindow/Scorelist/Five_Difficulty,
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
	Highscores.update_highscores(highscore_names, highscore_diff, highscore_orbs)
	if index != -1: _new_highscore_detected(index, current_score)
	else: _show_bad_score(current_score)
	$MainWindow.visible = true

func _new_highscore_detected(index, score) -> void:
	highscore_names[index].add_color_override("font_color", Color(1, 0.505882, 0.505882))
	highscore_orbs[index].add_color_override("font_color", Color(1, 0.505882, 0.505882))
	highscore_numbering[index].add_color_override("font_color", Color(1, 0.505882, 0.505882))
	highscore_diff[index].add_color_override("font_color", Color(1, 0.505882, 0.505882))
	highscore_news[index].visible = true
	enter_name_label.anchor_top = highscore_names[index].anchor_top
	enter_name_label.anchor_bottom = highscore_names[index].anchor_bottom
	enter_name_label.visible = true
	set_name_button.anchor_top = highscore_sets[index].anchor_top
	set_name_button.anchor_bottom = highscore_sets[index].anchor_bottom
	set_name_button.visible = true
	highscore_names[index].text = ""
	highscore_orbs[index].text = str(score)


func _show_bad_score(current_score) -> void:
	$MainWindow/Bad_Userscore/Bad_Score.text = str(current_score)
	$MainWindow/Bad_Userscore/Bad_Difficulty.text = str(Highscores._convert_difficulty_to_text(Globals.difficulty))
	$MainWindow/Bad_Userscore.visible = true
func _solidify_highscores() -> void: 
	Highscores.set_new_record_name("Unnamed")
	Highscores.write_highscores(Highscores.local_highscores)
	
func _ready() -> void: if Globals.connect("death", self, "_on_death") != OK: Globals.error_connect(self.name)
func _on_death() -> void: $AnimationPlayer.play("black")
func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void: _highscores_initialize(Globals.orb_count)
func _on_Button_pressed() -> void: 
	_solidify_highscores()
	var _success = get_tree().change_scene("res://src/level/Titlescreen.tscn")

func _on_set_name_button() -> void:
	for index in len(highscore_names):
		if highscore_names[index].text == "": highscore_names[index].text = enter_name_label.text
	Highscores.set_new_record_name(enter_name_label.text)
	enter_name_label.visible = false
	set_name_button.visible = false
