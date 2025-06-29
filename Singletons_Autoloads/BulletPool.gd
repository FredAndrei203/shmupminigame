extends Node

enum bullet_types {
	PLAYER_RAPID,
	MARKSMAN,
	SHOTGUNEER,
	PATTERN_SPAMMER
}

var bullet_scenes: Dictionary[bullet_types, PackedScene] = {
	bullet_types.PLAYER_RAPID: preload("res://Bullets/player_rapid_bullet.tscn"),
	bullet_types.MARKSMAN: preload("res://Bullets/marksman_bullet.tscn"),
	bullet_types.SHOTGUNEER: preload("res://Bullets/shotguneer_bullet.tscn"),
	bullet_types.PATTERN_SPAMMER: preload("res://Bullets/pattern_spammer_bullet.tscn")
}
var bullet_pools: Dictionary[bullet_types, Array]
var unpooled_bullets: Dictionary[bullet_types, Array]
var group_of_bullet_type: Dictionary[bullet_types, StringName] = {
	bullet_types.PLAYER_RAPID: "RapidFireBullet",
	bullet_types.MARKSMAN: "MarksmanBullet",
	bullet_types.SHOTGUNEER: "ShotguneerBullet",
	bullet_types.PATTERN_SPAMMER: "PatternSpammerBullet"
}

func _ready() -> void:
	for type in bullet_scenes.keys():
		var pool: Array[BulletBase]
		bullet_pools[type] = pool
		var unpooled: Array[BulletBase]
		unpooled_bullets[type] = unpooled



func request_bullet(type: bullet_types, location: Vector2, direction: Vector2):
	var pool: Array[BulletBase] = bullet_pools[type]
	var unpooled: Array[BulletBase] = unpooled_bullets[type]
	var bullet: BulletBase
	if pool.is_empty():
		bullet = bullet_scenes[type].instantiate()
		add_child(bullet)
	else:
		bullet = pool.pop_back()
	bullet.position = location
	bullet.bullet_direction = direction
	unpooled.append(bullet)
	activate_bullet(bullet)

func return_bullet(used_bullet: BulletBase):
	var type: bullet_types = used_bullet.bullet_type
	var pool: Array[BulletBase] = bullet_pools[type]
	var unpooled: Array[BulletBase] = unpooled_bullets[type]
	pool.append(used_bullet)
	unpooled.erase(used_bullet)
	deactivate_bullet(used_bullet)

func activate_bullet(bullet: BulletBase):
	bullet.set_process(true)
	bullet.set_physics_process(true)
	bullet.visible = true
	bullet.hurtbox.hurtbox_active = true
	bullet.animation_active = true

func deactivate_bullet(bullet: BulletBase):
	bullet.set_process(false)
	bullet.set_physics_process(false)
	bullet.visible = false
	bullet.hurtbox.hurtbox_active = false
	bullet.animation_active = false
	bullet.position = Vector2(0, 0)

func get_children_of_type(type: bullet_types) -> Array:
	return get_tree().get_nodes_in_group(group_of_bullet_type[type])
