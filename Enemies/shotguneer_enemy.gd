class_name ShotguneerEnemy
extends EnemyBase

func _ready() -> void:
	speed = 350
	weapon = $ShotguneerWeapon
	enemy_type = EnemyPool.enemy_types.SHOTGUNEER
	max_health = 20
	health = max_health
	max_fire_count = 2
	fire_count = max_fire_count
