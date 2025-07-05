class_name WeaponBase
extends Node2D

signal weapon_ready

@onready var cooldown: Timer = $Cooldown

var bullet_type: BulletPool.bullet_types
var can_fire: bool = true
var firing_direction: Vector2

var weapon_activated: bool = true:
	set(active):
		weapon_activated = active
		if !weapon_activated:
			cooldown.stop()
			can_fire = false
		else:
			can_fire = true

func fire_weapon():
	pass


func _on_cooldown_timeout() -> void:
	can_fire = true
	weapon_ready.emit()
