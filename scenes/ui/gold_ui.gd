class_name GoldUi
extends HBoxContainer

@export var run_stats: RunStats : set = set_run_stats

@onready var label: Label = $Label

func _ready() -> void:
	label.text = "0"
	
func set_run_stats(val: RunStats) -> void:
	run_stats = val
	
	if not run_stats.gold_changed.is_connected(_update_gold):
		run_stats.gold_changed.connect(_update_gold)
		_update_gold()

func _update_gold() -> void:
	label.text = str(run_stats.gold)
