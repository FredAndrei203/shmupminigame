class_name Entity
extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
var weapon: WeaponBase
var speed: float:
	get = get_speed
var animation_active: bool = true:
	set(active):
		animation_active = active
		if active:
			sprite.play()
		else:
			sprite.stop()
var hitbox_active: bool = true:
	set(active):
		hitbox_active = active
		if hitbox_active:
			hitbox.set_deferred("monitoring", true)
			hitbox.set_deferred("monitorable", true)
		else:
			hitbox.set_deferred("monitoring", false)
			hitbox.set_deferred("monitorable", false)

#To keep track of previous lateral velocity (for animation change purposes)
var previous_lateral_velocity: int = 0

func get_speed():
	return speed

func detect_lateral_velocity_change():
	if sign(velocity.x) != previous_lateral_velocity:
		change_animation(sign(velocity.x))
		previous_lateral_velocity = sign(velocity.x)

#Change animation upon detecting change in lateral direction
func change_animation(new_velocity: int) -> void:
	if new_velocity == -1:
		sprite.play_move_left()
	elif new_velocity == 1:
		sprite.play_move_right()
	elif new_velocity == 0:
		sprite.play_normal()
