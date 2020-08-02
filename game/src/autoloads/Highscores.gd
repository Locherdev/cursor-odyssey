extends Node

const highscores_path = "user://co_highscores.save"
var local_highscores
const initial_highscores = [
	{ "id": 0, "name": "CURSOR ODYSSEY", "record": 30 },
	{ "id": 1, "name": "CURSOR ODYSSEY", "record": 25 },
	{ "id": 2, "name": "CURSOR ODYSSEY", "record": 20 },
	{ "id": 3, "name": "CURSOR ODYSSEY", "record": 15 },
	{ "id": 4, "name": "CURSOR ODYSSEY", "record": 10 }
	]

func write_highscores(highscores = initial_highscores) -> void:
	var file = File.new()
	file.open(highscores_path, File.WRITE)
	for index in len(highscores):
		if index == 5: break
		file.store_line(to_json(highscores[index]))
	file.close()

func update_highscores(highscore_names = Array(), highscore_records = Array(), highscores = load_highscores()) -> void:
	for index in len(highscores):
		if index == 5: break
		highscore_names[highscores[index]["id"]].text = highscores[index]["name"]
		highscore_records[highscores[index]["id"]].text = str(highscores[index]["record"])

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
			var new_score_entry = { "id": index, "name": "", "record": new_score }
			loaded_highscores.insert(index, new_score_entry)
			local_highscores = _recalculate_ids(loaded_highscores)
			return index
	return -1

func _recalculate_ids(highscores) -> Array:
	for index in len(highscores): highscores[index]["id"] = index
	return highscores
