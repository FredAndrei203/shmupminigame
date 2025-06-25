class_name RapidFireWeapon
extends WeaponBase

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.PLAYER_RAPID
	firing_direction = Vector2(0, -1)

#Fire a bullet when ready
func fire_weapon():
	if can_fire:
		var muzzles: Array = $Muzzles.get_children()
		for muzzle in muzzles:
			BulletPool.request_bullet(bullet_type, muzzle.global_position, firing_direction)
		can_fire = false
		cooldown.start()
