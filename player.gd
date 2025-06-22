class_name Player
extends Entity

#The weapon of the player
@onready var hitbox_sprite = $HitboxSprite

func _ready() -> void:
	weapon = $RapidFireWeapon
	speed = 600

#Slowed movement speed
var focus_speed_mod: float = 0.4
var focusing: bool = false: #If slowing down (holding shift)
	set(is_focusing):
		focusing = is_focusing
		hitbox_sprite.visible = is_focusing
var movement_direction: Vector2 = Vector2(0, 0)



#Every frame, detect lateral velocity change, and change player animation accordingly
func _physics_process(delta: float) -> void:
	detect_lateral_velocity_change()
	move_and_slide()

func fire_weapon():
	weapon.fire_weapon()

func get_speed():
	if focusing:
		return speed * focus_speed_mod
	else:
		return speed


func _on_hitbox_area_entered(area: Area2D) -> void:
	pass
