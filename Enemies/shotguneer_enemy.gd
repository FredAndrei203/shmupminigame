class_name ShotguneerEnemy
extends EnemyBase

func _ready() -> void:
	speed = 350
	
	enemy_type = EnemyPool.enemy_types.SHOTGUNEER
	max_health = 6
	health = max_health


func _on_preparation_timer_timeout() -> void:
	weapon.firing_direction = (target.global_position - global_position).normalized()
	weapon.fire_weapon()
	request_next_destination.emit(self)
