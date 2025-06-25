class_name ShotguneerWeapon
extends WeaponBase

@onready var muzzle_group = $Muzzles

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.SHOTGUNEER

func fire_weapon():
	rotation = firing_direction.angle()
	var muzzles: Array[Node] = muzzle_group.get_children()
	for muzzle in muzzles:
		BulletPool.request_bullet(bullet_type, muzzle.global_position, firing_direction.rotated(muzzle.rotation))
	cooldown.start()
