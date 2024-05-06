extends Control

const CHAR_SELECTION_SCENE := preload("res://scenes/ui/character_selection.tscn")

@onready var continue_button: Button = %Continue

func _ready() -> void:
	get_tree().paused = false

# TODO
func _on_continue_pressed():
	print("continue btn click")


func _on_new_run_pressed():
	get_tree().change_scene_to_packed(CHAR_SELECTION_SCENE)


func _on_exit_pressed():
	get_tree().quit()
