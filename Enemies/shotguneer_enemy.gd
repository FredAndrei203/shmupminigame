class_name ShotguneerEnemy
extends EnemyBase

func _ready() -> void:
	speed = 350
	weapon = $ShotguneerWeapon
	weapon.weapon_ready.connect(engage_target)
	enemy_type = EnemyPool.enemy_types.SHOTGUNEER
	max_health = 20
	health = max_health
	max_fire_count = 1
