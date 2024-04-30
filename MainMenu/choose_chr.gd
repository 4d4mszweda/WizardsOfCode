extends Control


func _process(delta):
	match Game.PlayerSelect:
		0:
			get_node("PlayerSelect").play("python")
			get_node("Des").text = Game.Characters[0]
		1:
			get_node("PlayerSelect").play("test1")
			get_node("Des").text = Game.Characters[1]
		2:
			get_node("PlayerSelect").play("test2")
			get_node("Des").text = Game.Characters[2]

# Aktualnie są 3 postacie dla testu więc, 0, 1, 2 
func _on_button_next_pressed():
	if Game.PlayerSelect == Game.Characters.size() - 1:
		Game.PlayerSelect = -1
	Game.PlayerSelect += 1


func _on_button_prev_pressed():
	if Game.PlayerSelect == 0:
		Game.PlayerSelect = 3
	Game.PlayerSelect -= 1


func _on_select_pressed():
	get_tree().change_scene_to_file("res://Game/GameMap.tscn")
