class_name EnemyPool
extends Node

enum enemy_types {
	MARKSMAN,
	SHOTGUNEER,
	PATTERNSPAMMER
}

static var enemy_scenes: Dictionary[enemy_types, PackedScene] = {
	enemy_types.MARKSMAN: preload("res://Enemies/marksman_enemy.tscn"),
	enemy_types.SHOTGUNEER: preload("res://Enemies/shotguneer_enemy.tscn")
}
static var enemy_pools: Dictionary[enemy_types, Array]
static var unpooled_enemies: Dictionary[enemy_types, Array]
static var group_of_enemy_type: Dictionary[enemy_types, StringName] = {
	enemy_types.MARKSMAN: "Marksman",
	enemy_types.SHOTGUNEER: "Shotguneer"#,
	#enemy_types.PATTERNSPAMMER: "PatternSpammer"
}

static func initialize_arrays_of_pools():
	for type in enemy_scenes.keys():
		var pool: Array[EnemyBase]
		enemy_pools[type] = pool
		var unpooled: Array[EnemyBase]
		unpooled_enemies[type] = unpooled

static func request_enemy(type: enemy_types) -> EnemyBase:
	var pool: Array[EnemyBase] = enemy_pools[type]
	var unpooled: Array[EnemyBase] = unpooled_enemies[type]
	var enemy: EnemyBase
	if pool.is_empty():
		enemy = enemy_scenes[type].instantiate()
		unpooled.append(enemy)
		return enemy
	else:
		enemy = pool.pop_back()
		unpooled.append(enemy)
		return enemy

static func return_enemy(used_enemy: EnemyBase):
	var type: enemy_types = used_enemy.enemy_type
	var pool: Array[EnemyBase] = enemy_pools[type]
	var unpooled: Array[EnemyBase] = unpooled_enemies[type]
	pool.append(used_enemy)
	unpooled.erase(used_enemy)
	deactivate_enemy(used_enemy)

static func activate_enemy(enemy: EnemyBase):
	enemy.set_process(true)
	enemy.set_physics_process(true)
	enemy.visible = true
	enemy.hurtbox.hurtbox_active = true
	enemy.animation_active = true
	enemy.weapon.weapon_activated = true
	enemy.hitbox_active = true
	enemy.health = enemy.max_health
	enemy.is_destroyed = false
	enemy.is_attacking = false

static func deactivate_enemy(enemy: EnemyBase):
	enemy.set_process(false)
	enemy.set_physics_process(false)
	enemy.visible = false
	enemy.hurtbox.hurtbox_active = false
	enemy.animation_active = false
	enemy.position = Vector2.ZERO
	enemy.preparation_timer.stop()
	enemy.weapon.weapon_activated = false
	enemy.hitbox_active = false
