class_name ShotguneerEnemy
extends EnemyBase

func _ready() -> void:
	speed = 350
	weapon = $ShotguneerWeapon
	enemy_type = EnemyPool.enemy_types.SHOTGUNEER
	max_health = 6
	health = max_health
	fire_count = 2

func engage_target():
	weapon.firing_direction = (target.global_position - global_position).normalized()
	weapon.fire_weapon()
	fire_count -= 1
	if fire_count <= 0:
		request_next_destination.emit(self)
		fire_count = 2
	else:
		await weapon.weapon_ready
		engage_target()
