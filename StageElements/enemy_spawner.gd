class_name EnemySpawner
extends Node2D

@onready var spawn_area = $SpawnAreas
@onready var spawn_point = $SpawnAreas/SpawnPoint
@onready var next_wave_timer = $NextWaveTimer
@onready var spawn_timer = $SpawnTimer

var destinations: EnemyDestinations
var spawn_queue: Array[EnemyBase]
var target_of_malice: Player
var children: Array[EnemyBase]

func choose_random_enemies():
	spawn_sqaudron(1, EnemyPool.enemy_types.SHOTGUNEER)

func spawn_sqaudron(count: int, type: EnemyPool.enemy_types):
	spawn_point.progress_ratio = randf()
	var random_destination: Vector2 = destinations.get_random_destination()
	for idx in range(count):
		var enemy: EnemyBase = EnemyPool.request_enemy(type)
		enemy.position = spawn_point.position
		enemy.destination = random_destination
		spawn_queue.append(enemy)
	spawn_timer.start()


func _on_next_wave_timer_timeout() -> void:
	choose_random_enemies()


func _on_spawn_timer_timeout() -> void:
	if !spawn_queue.is_empty():
		var enemy: EnemyBase = spawn_queue.pop_front()
		if !children.has(enemy):
			enemy.request_next_destination.connect(_on_enemy_base_request_next_destination)
			enemy.target = target_of_malice
			add_child(enemy)
			children.append(enemy)
		EnemyPool.activate_enemy(enemy)
		spawn_timer.start()

func _on_enemy_base_request_next_destination(enemy: EnemyBase):
	var random_destination: Vector2 = destinations.get_random_destination()
	enemy.destination = random_destination
	enemy.is_attacking = false

func get_children_of_type(type: EnemyPool.enemy_types) -> Array:
	var group_str: StringName = EnemyPool.group_of_enemy_type[type]
	return get_tree().get_nodes_in_group(group_str)
