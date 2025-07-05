class_name Player
extends Entity

#The weapon of the player
@onready var hitbox_sprite = $HitboxSprite
var screen_size
signal is_hit
signal focus_engaged(focus: bool)

var is_dead: bool = false

func _ready() -> void:
	weapon = $RapidFireWeapon
	speed = 600
	screen_size = get_viewport_rect().size
	

#Slowed movement speed
var focus_speed_mod: float = 0.4
var focusing: bool = false: #If slowing down (holding shift)
	set(is_focusing):
		focusing = is_focusing
		hitbox_sprite.visible = is_focusing
		focus_engaged.emit(focusing)
var movement_direction: Vector2 = Vector2(0, 0)



#Every frame, detect lateral velocity change, and change player animation accordingly
func _physics_process(_delta: float) -> void:
	detect_lateral_velocity_change()
	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)

func fire_weapon():
	weapon.fire_weapon()

func get_speed():
	if focusing:
		return speed * focus_speed_mod
	else:
		return speed


func _on_hitbox_area_entered(_area: Area2D) -> void:
	is_hit.emit()
