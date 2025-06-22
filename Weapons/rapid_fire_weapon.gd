class_name RapidFireWeapon
extends WeaponBase

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.PLAYER_RAPID
	firing_direction = Vector2(0, -1)

#Fire a bullet when ready
func fire_weapon():
	if can_fire:
		BulletPool.request_bullet(bullet_type, $BulletMuzzle1.global_position, firing_direction)
		BulletPool.request_bullet(bullet_type, $BulletMuzzle2.global_position, firing_direction)
		can_fire = false
		cooldown.start()
