class_name MarksmanEnemy
extends EnemyBase



func _ready() -> void:
	speed = 600
	weapon = $MarksmanWeapon
	enemy_type = EnemyPool.enemy_types.MARKSMAN
	max_health = 3
	health = max_health
	max_fire_count = 1
	fire_count = max_fire_count
