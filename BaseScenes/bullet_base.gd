class_name BulletBase
extends CharacterBody2D

#Composition pattern could have been used for the hurtbox
#But bullets will only be the ones with hurtboxes so imma keep it simple
@onready var hurtbox: HurtboxComponent = $HurtboxComponent
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var damage: float

var animation_active: bool = true:
	set(active):
		animation_active = active
		if animation_active:
			sprite.play()
		else:
			sprite.stop()

var bullet_type: BulletPool.bullet_types
var bullet_speed: float = 0
var bullet_direction: Vector2 = Vector2(0, 0):
	set(new_direction):
		bullet_direction = new_direction
		velocity = bullet_direction * bullet_speed

func _physics_process(delta: float) -> void:
	move_and_slide()
	deactivate_if_outside_view()

#The bullet puts itself in the pool if out of bounds
func deactivate_if_outside_view():
	var viewport_rect: Rect2 = get_viewport_rect()
	var margin = 50
	var expanded_viewport_rect: Rect2 = Rect2(
		viewport_rect.position.x - margin,
		viewport_rect.position.y - margin,
		viewport_rect.size.x + 2 * margin,
		viewport_rect.size.y + 2 * margin
	)
	if !expanded_viewport_rect.has_point(global_position):
		BulletPool.return_bullet(self)


func _on_hurtbox_component_area_entered(area: Area2D) -> void:
	BulletPool.return_bullet(self)
