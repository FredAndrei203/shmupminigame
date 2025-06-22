class_name DeveloperTool
extends Control

@onready var bullet_pool_stats = $Stats/BulletPoolStats
@onready var enemy_pool_stats = $Stats/EnemyPoolStats

var enemy_spawner: EnemySpawner:
	set(new_spawner):
		enemy_spawner = new_spawner
		enemy_pool_stats.enemy_spawner = enemy_spawner
