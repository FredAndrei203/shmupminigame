class_name MarksmanEnemy
extends EnemyBase



func _ready() -> void:
	speed = 600
	weapon = $MarksmanWeapon
	enemy_type = EnemyPool.enemy_types.MARKSMAN
	max_health = 3
	health = max_health
	fire_count = 2

func engage_target():
	weapon.firing_direction = (target.global_position - global_position).normalized()
	weapon.fire_weapon()
	fire_count -= 1
	if fire_count <= 0:
		request_next_destination.emit(self)
		fire_count = 3
	else:
		await weapon.weapon_ready
		engage_target()
