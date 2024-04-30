extends Node2D

func _process(delta):
	get_node("Label").text = Game.Characters[Game.PlayerSelect]
