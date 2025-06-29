class_name PatternSpammerEnemy
extends EnemyBase

func _ready() -> void:
	speed = 100
	weapon = $PatternSpammerWeapon
	weapon.weapon_ready.connect(engage_target)
	enemy_type = EnemyPool.enemy_types.PATTERNSPAMMER
	max_health = 50
	health = max_health
	max_fire_count = 50
