class_name PatternSpammerBullet
extends BulletBase

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.PATTERN_SPAMMER
	bullet_speed = 100
