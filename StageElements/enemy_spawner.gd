class_name EnemySpawner
extends Node2D

@onready var spawn_area = $SpawnAreas
@onready var spawn_point = $SpawnAreas/SpawnPoint
@onready var next_wave_timer: Timer = $NextWaveTimer
@onready var spawn_timer: Timer = $SpawnTimer

var destinations: EnemyDestinations
var spawn_queue: Array[EnemyBase]
var target_of_malice: Player
var children: Array[EnemyBase]
var has_spawned_leaders: bool = false
var has_spawned_high_ranks: bool = false

var max_pattern_spammer_on_play: int = 2
var max_shotguneers_on_play: int = 10
var max_markmen_on_play: int = 15

func reset_spawner():
	spawn_queue.clear()
	has_spawned_high_ranks = false
	has_spawned_leaders = false
	next_wave_timer.stop()
	spawn_timer.stop()

func deploy_next_squad():
	var spammer_count: int = EnemyPool.unpooled_enemies[EnemyPool.enemy_types.PATTERNSPAMMER].size()
	var shotguneer_count: int = EnemyPool.unpooled_enemies[EnemyPool.enemy_types.SHOTGUNEER].size()
	var marksmen_count: int = EnemyPool.unpooled_enemies[EnemyPool.enemy_types.MARKSMAN].size()
	
	if spammer_count < max_pattern_spammer_on_play and !has_spawned_high_ranks and !has_spawned_leaders:
		var count: int = min(max_pattern_spammer_on_play, max_pattern_spammer_on_play - spammer_count)
		spawn_squadron(count , EnemyPool.enemy_types.PATTERNSPAMMER, true)
		has_spawned_high_ranks = true
		has_spawned_leaders = true
	elif shotguneer_count < max_shotguneers_on_play and !has_spawned_high_ranks:
		var count: int = min(5, max_shotguneers_on_play - shotguneer_count)
		spawn_squadron(count, EnemyPool.enemy_types.SHOTGUNEER, true)
		has_spawned_high_ranks = true
		has_spawned_leaders = false
	elif marksmen_count < max_markmen_on_play and has_spawned_high_ranks:
		var count: int = min(10, max_markmen_on_play - marksmen_count)
		spawn_squadron(count, EnemyPool.enemy_types.MARKSMAN, false)
		has_spawned_high_ranks = false
	
	next_wave_timer.start()

func spawn_squadron(count: int, type: EnemyPool.enemy_types, rand_dir: bool):
	spawn_point.progress_ratio = randf()
	var random_destination: Vector2 = destinations.get_random_destination()
	
	for idx in range(count):
		var enemy: EnemyBase = EnemyPool.request_enemy(type)
		enemy.position = spawn_point.position
		
		if rand_dir:
			enemy.destination = destinations.get_random_destination()
		else:
			enemy.destination = random_destination
		
		spawn_queue.append(enemy)
	
	spawn_timer.start()


func _on_next_wave_timer_timeout() -> void:
	deploy_next_squad()


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
