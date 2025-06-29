class_name MarksmanEnemy
extends EnemyBase



func _ready() -> void:
	speed = 600
	weapon = $MarksmanWeapon
	weapon.weapon_ready.connect(engage_target)
	enemy_type = EnemyPool.enemy_types.MARKSMAN
	max_health = 3
	health = max_health
	max_fire_count = 1
