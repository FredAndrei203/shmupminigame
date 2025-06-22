class_name MarksmanWeapon
extends WeaponBase

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.MARKSMAN

func fire_weapon():
	BulletPool.request_bullet(bullet_type, global_position, firing_direction)
