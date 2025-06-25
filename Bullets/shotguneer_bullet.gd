class_name ShotguneerBullet
extends BulletBase

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.SHOTGUNEER
	bullet_speed = 200
