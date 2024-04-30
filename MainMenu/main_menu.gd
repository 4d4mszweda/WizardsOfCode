extends Control

#Jeśli nie ma do wczytania poprzedniej gry to powinnien continue btn być inactive

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://MainMenu/choose_chr.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()


# TODO 
func _on_continue_pressed():
	pass # Replace with function body.

# TODO
func _on_options_pressed():
	pass # Replace with function body.

# Link to test scene
func _on_test_mode_pressed():
	get_tree().change_scene_to_file("res://TestMode/TestMode.tscn")
