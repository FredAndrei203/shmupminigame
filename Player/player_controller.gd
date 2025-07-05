class_name PlayerController
extends Node2D

var player: Player:
	set(new_player):
		if player != null:
			player.is_hit.disconnect(_on_player_is_hit)
		player = new_player
		player.is_hit.connect(_on_player_is_hit)

func _process(_delta: float) -> void:
	if !player.is_dead:
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

func respawn_player() -> void:
	player.position = Vector2(577, 486)
	player.hitbox_active = true
	player.is_dead = false
	player.show()

func despawn_player() -> void:
	player.hitbox_active = false
	player.is_dead = true
	player.hide()

func _on_player_is_hit():
	despawn_player()
