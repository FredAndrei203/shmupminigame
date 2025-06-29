class_name PatternSpammerWeapon
extends WeaponBase

@onready var muzzles_node: Node2D = $Muzzles
var muzzle_array: Array[Marker2D]

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.PATTERN_SPAMMER
	for child in muzzles_node.get_children():
		muzzle_array.append(child)

func fire_weapon():
	for muzzle in muzzle_array:
		BulletPool.request_bullet(bullet_type, muzzle.global_position, Vector2.RIGHT.rotated(muzzle.global_rotation))
	rotate(deg_to_rad(45/2))
	cooldown.start()
