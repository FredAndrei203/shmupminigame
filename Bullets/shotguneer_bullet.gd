class_name ShotguneerBullet
extends BulletBase

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.SHOTGUNEER
	bullet_speed = 1000

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward((bullet_speed * bullet_direction)/7.5, delta * 2000)
	move_and_slide()
	deactivate_if_outside_view()
