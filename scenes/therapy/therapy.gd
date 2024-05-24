class_name Campfire
extends Control

@export var char_stats: CharacterStats

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_rest_button_pressed() -> void:
	char_stats.heal(ceili(char_stats.max_health * 0.3))
	Events.therapy_exited.emit()
