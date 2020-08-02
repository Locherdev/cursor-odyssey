extends Node

const highscores_path = "user://co_highscores.save"
var local_highscores
const initial_highscores = [
	{ "id": 0, "name": "[nw@] Toni", "diff": 3, "record": 15 },
	{ "id": 1, "name": "[nw@] Toni", "diff": 2, "record": 10 },
	{ "id": 2, "name": "[nw@] Marc", "diff": 1, "record": 5 },
	{ "id": 3, "name": "[nw@] Fabian", "diff": 1, "record": 3 },
	{ "id": 4, "name": "[nw@] Fabian", "diff": 0, "record": 1 }
	]

func write_highscores(highscores = initial_highscores) -> void:
	var file = File.new()
	file.open(highscores_path, File.WRITE)
	for index in len(highscores):
		if index == 5: break
		file.store_line(to_json(highscores[index]))
	file.close()

func update_highscores(highscore_names = Array(), highscore_diff = Array(), highscore_records = Array()) -> void:
	var highscores = local_highscores if local_highscores else load_highscores()
	for index in len(highscores):
		if index == 5: break
		highscore_names[highscores[index]["id"]].text = highscores[index]["name"]
		highscore_records[highscores[index]["id"]].text = str(highscores[index]["record"])
		highscore_diff[highscores[index]["id"]].text = _convert_difficulty_to_text(int(highscores[index]["diff"]))

func _convert_difficulty_to_text(difficulty) -> String:
	match difficulty:
		0: return "Easy"
		1: return "Normal"
		2: return "Hard"
		3: return "Expert"
		_: return "Null"

func load_highscores() -> Array:
	var file = File.new()
	file.open(highscores_path, File.READ)
	var loaded_highscores = []
	while file.get_position() < file.get_len(): loaded_highscores.append(parse_json(file.get_line()))
	file.close()
	return loaded_highscores

func evaluate_new_score(new_score:int) -> int:
	var loaded_highscores = load_highscores()
	local_highscores = loaded_highscores
	for index in len(loaded_highscores):
		var score = loaded_highscores[index]
		if new_score > score["record"]:
			var new_score_entry = { "id": index, "name": "", "diff": Globals.difficulty, "record": new_score }
			loaded_highscores.insert(index, new_score_entry)
			local_highscores = _recalculate_ids(loaded_highscores)
			return index
	return -1

func _recalculate_ids(highscores) -> Array:
	for index in len(highscores): highscores[index]["id"] = index
	return highscores

func set_new_record_name(name) -> void:
	for index in len(local_highscores): 
		if local_highscores[index]["name"] == "": local_highscores[index]["name"] = name
