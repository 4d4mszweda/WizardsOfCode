class_name Run
extends Node

const BATTLE_SCENE := preload("res://scenes/battle/battle.tscn")
const BATTLE_REWORD_SCENE := preload("res://scenes/battle_rewards/battle_rewards.tscn")
const THERAPY_SCENE := preload("res://scenes/therapy/therapy.tscn")
#const MAP_SCENE := preload("res://scenes/map/map.tscn")
const SHOP_SCENE := preload("res://scenes/shop/shop.tscn")
const TREASURE_SCENE := preload("res://scenes/treasure/treasure.tscn")

@export var run_startup: RunStartup

@onready var current_view: Node = $CurrentView
@onready var gold_ui: GoldUi = %GoldUi
@onready var deck_button: CardPileOpener = %DeckButton
@onready var deck_view: CardPileView = %DeckView
@onready var battle_button: Button = %BattleButton
@onready var shop_button: Button = %ShopButton
@onready var treasure_button: Button = %TreasureButton
@onready var rewards_button: Button = %RewardsButton
@onready var theraoy_button: Button = %TherapyButton
@onready var map_button: Button = %MapButton
@onready var health: HealthUI = %HealthUI

@onready var map = $Map

var stats: RunStats
var character: CharacterStats

func _ready() -> void:
	if not run_startup:
		return
	match run_startup.type:
		RunStartup.Type.NEW_RUN:
			character = run_startup.picked_character.create_instance()
			_start_run()
		RunStartup.Type.CONTINUED_RUN:
			print("TODO: load last game")
		
func _start_run() -> void:
	stats = RunStats.new()
	_setup_event_connections()
	_setup_top_bar()
	map.generate_new_map()
	map.unlock_floor(0)
	
	#TEST
	#await get_tree().create_timer(3).timeout
	#stats.gold += 5


func _change_view(scene: PackedScene) -> Node:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
		
	get_tree().paused = false
	var new_view := scene.instantiate()
	current_view.add_child(new_view)
	map.hide_map()
	
	return new_view

func  _on_battle_room_entered(room: Room) -> void:
	var battle_scene: Battle = _change_view(BATTLE_SCENE) as Battle
	battle_scene.char_stats = character
	battle_scene.battle_stats = room.battle_stats
	#battle_scene.battle_stats = preload("res://battles/tier_0_bats2.tres")
	battle_scene.start_battle()

func _on_campfire_entered() -> void:
	var campfire := _change_view(THERAPY_SCENE) as Campfire
	campfire.char_stats = character

func _show_map() -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	map.show_map()
	map.unlock_next_rooms()
	
func _on_treasure_entered() -> void:
	var reward_scene := _change_view(BATTLE_REWORD_SCENE) as BattleReward
	reward_scene.run_status = stats
	reward_scene.character_stats = character
	
	reward_scene.add_gold_reward(100)
	reward_scene.add_card_reward()
	reward_scene.add_card_reward()

func _setup_event_connections() -> void:
	Events.battle_won.connect(_on_battle_won)
	Events.battle_reward_exited.connect(_show_map)
	Events.therapy_exited.connect(_show_map)
	Events.map_exited.connect(_on_map_exited)
	Events.shop_exited.connect(_show_map)
	Events.treasure_room_exited.connect(_show_map)

	battle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))
	theraoy_button.pressed.connect(_change_view.bind(THERAPY_SCENE))
	map_button.pressed.connect(_show_map)
	rewards_button.pressed.connect(_change_view.bind(BATTLE_REWORD_SCENE))
	shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	treasure_button.pressed.connect(_change_view.bind(TREASURE_SCENE))	

func _setup_top_bar() -> void:
	character.stats_changed.connect(health.update_stats.bind(character))
	health.update_stats(character)
	gold_ui.run_stats = stats
	deck_button.card_pile = character.deck
	deck_view.card_pile = character.deck
	deck_button.pressed.connect(deck_view.show_current_view.bind("Deck"))

func _on_battle_won() -> void:
	var reward_scene := _change_view(BATTLE_REWORD_SCENE) as BattleReward
	reward_scene.run_status = stats
	reward_scene.character_stats = character
	
	#TEMP
	reward_scene.add_gold_reward(map.last_room.battle_stats.roll_gold_reward())
	reward_scene.add_card_reward()

func _on_map_exited(room: Room) -> void:
	#_save_run()
	
	match room.type:
		Room.Type.MONSTER:
			_on_battle_room_entered(room)
			#_change_view(BATTLE_SCENE)
		Room.Type.TREASURE:
			#_on_treasure_room_entered()
			_on_treasure_entered()
		Room.Type.CAMPFIRE:
			_on_campfire_entered()
			#_change_view(THERAPY_SCENE)
		Room.Type.SHOP:
			#_on_shop_entered()
			_change_view(SHOP_SCENE)
		Room.Type.BOSS:
			_on_battle_room_entered(room)
			#_change_view(BATTLE_SCENE)
