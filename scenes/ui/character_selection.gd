extends Control

const RUN_SCENE := preload("res://scenes/run/run.tscn")
const PYTHON_STATS := preload("res://characters/warrior/warrior.tres")
const JS_STATS := preload("res://characters/js/js.tres")
const JAVA_STATS := preload("res://characters/java/java.tres")

@export var run_startup: RunStartup

@onready var title: Label = %Name
@onready var description: Label = %Description
@onready var character_portrait: TextureRect = %CharacterPortriat

var current_character: CharacterStats : set = set_current_character

func _ready() -> void:
	set_current_character(PYTHON_STATS)

func set_current_character(new_character: CharacterStats) -> void:
	current_character = new_character
	title.text = current_character.character_name
	description.text = current_character.description
	character_portrait.texture = current_character.portrait

func _on_start_button_pressed() -> void:
	print("START BTN with %s" % current_character.character_name)
	run_startup.type = RunStartup.Type.NEW_RUN
	run_startup.picked_character = current_character
	get_tree().change_scene_to_packed(RUN_SCENE)


func _on_python_button_pressed() -> void:
	current_character = PYTHON_STATS


func _on_js_button_pressed() -> void:
	current_character = JS_STATS


func _on_java_button_pressed() -> void:
	current_character = JAVA_STATS
