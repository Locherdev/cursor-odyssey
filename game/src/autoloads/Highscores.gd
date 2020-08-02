extends Node

const highscores_path = "user://co_highscores.save"
const initial_highscores = [
	{ "id": 0, "name": "CURSOR ODYSSEY", "record": "30" },
	{ "id": 1, "name": "CURSOR ODYSSEY", "record": "25" },
	{ "id": 2, "name": "CURSOR ODYSSEY", "record": "20" },
	{ "id": 3, "name": "CURSOR ODYSSEY", "record": "15" },
	{ "id": 4, "name": "CURSOR ODYSSEY", "record": "10" }
	]

func create_initial_highscores() -> void:
	var file = File.new()
	file.open(highscores_path, File.WRITE)
	for score in initial_highscores: file.store_line(to_json(score))
	file.close()

func load_highscores() -> Array:
	var file = File.new()
	file.open(highscores_path, File.READ)
	var loaded_highscores = []
	while file.get_position() < file.get_len(): loaded_highscores.append(parse_json(file.get_line()))
	file.close()
	return loaded_highscores
