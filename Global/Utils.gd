extends Resource

const SAVE_PATH := "user://savegame.tres"



func save_game() -> void:
	ResourceSaver.save(self, SAVE_PATH)
	
static func load_save_game() -> Resource:
	if ResourceLoader.exists(SAVE_PATH):
		return load(SAVE_PATH)
	return null

