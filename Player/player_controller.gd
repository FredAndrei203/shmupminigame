class_name PlayerController
extends Node2D

var player: Player

func _process(delta: float) -> void:
	detect_direction_input()
	detect_if_focusing()
	detect_if_firing()
	translate_movement_input()

func detect_direction_input():
	var x_axis: float = Input.get_axis("left", "right")
	var y_axis: float = Input.get_axis("up", "down")
	player.movement_direction = Vector2(x_axis, y_axis).normalized()

func detect_if_focusing():
	if Input.is_action_pressed("focus"):
		player.focusing = true
	else:
		player.focusing = false

func detect_if_firing():
	if Input.is_action_pressed("shoot"):
		player.fire_weapon()

func translate_movement_input():
	player.velocity = player.speed * player.movement_direction
