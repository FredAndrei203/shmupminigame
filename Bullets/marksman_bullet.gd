class_name MarksmanBullet
extends BulletBase

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.MARKSMAN
	bullet_speed = 400
