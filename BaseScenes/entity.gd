class_name Entity
extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
var weapon: WeaponBase
var speed: float:
	get = get_speed
var animation_active: bool = true:
	set(active):
		animation_active = active
		if active:
			sprite.stop()
		else:
			sprite.play()


func get_speed():
	return speed
