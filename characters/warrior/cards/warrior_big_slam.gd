extends Card


func apply_effects(targets: Array[Node]):
	var dmg_effect := DamageEffect.new()
	dmg_effect.amount = 10
	dmg_effect.sound = sound
	dmg_effect.execute(targets)
	print("sts effect apply")

