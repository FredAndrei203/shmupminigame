class_name MarksmanEnemy
extends EnemyBase

func _ready() -> void:
	speed = 500
	weapon = $MarksmanWeapon


func _on_preparation_timer_timeout() -> void:
	weapon.firing_direction = (target.global_position - global_position).normalized()
	weapon.fire_weapon()
	request_next_destination.emit(self)
