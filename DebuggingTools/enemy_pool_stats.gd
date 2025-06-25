class_name EnemyPoolStats
extends VBoxContainer

#The labels
@onready var total_instances_label = $TotalInstances
@onready var pooled_count_label = $Pooled
@onready var unpooled_count_label = $Unpooled
@onready var discrepancy_label = $Discrepancy

var enemy_spawner: EnemySpawner

var enemy_type_target: EnemyPool.enemy_types = EnemyPool.enemy_types.SHOTGUNEER


func _process(delta: float) -> void:
	count_total_instances_of_type(enemy_type_target)
	count_pooled_instances_of_type(enemy_type_target)
	count_unpooled_instances_of_type(enemy_type_target)
	get_discrepancy_of_type(enemy_type_target)


func count_total_instances_of_type(type: EnemyPool.enemy_types):
	var instances: Array = enemy_spawner.get_children_of_type(type)
	total_instances_label.text = "Total enemies in scene: " + str(instances.size())


func count_pooled_instances_of_type(type: EnemyPool.enemy_types):
	var pool = EnemyPool.enemy_pools[type]
	pooled_count_label.text = "Pooled: " + str(pool.size())


func count_unpooled_instances_of_type(type: EnemyPool.enemy_types):
	var unpooled = EnemyPool.unpooled_enemies[type]
	unpooled_count_label.text = "Unpooled: " + str(unpooled.size())


func get_discrepancy_of_type(type: EnemyPool.enemy_types):
	var instances: Array = enemy_spawner.get_children_of_type(type)
	var pool = EnemyPool.enemy_pools[type]
	var unpooled = EnemyPool.unpooled_enemies[type]
	var discrepancy: int = instances.size() - (pool.size() + unpooled.size())
	discrepancy_label.text = "Discrepancy: " + str(discrepancy)
