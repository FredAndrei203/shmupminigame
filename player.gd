class_name Player
extends Entity

#To signal if velocity changed (For animation change purposes)
signal lateral_velocity_changed(new_velocity: int)

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

#To keep track of previous lateral velocity (for animation change purposes)
var previous_lateral_velocity: int = 0

#Every frame, detect lateral velocity change, and change player animation accordingly
func _physics_process(delta: float) -> void:
	detect_lateral_velocity_change()
	move_and_slide()

func detect_lateral_velocity_change():
	if sign(velocity.x) != previous_lateral_velocity:
		lateral_velocity_changed.emit(sign(velocity.x))
		previous_lateral_velocity = sign(velocity.x)

func fire_weapon():
	weapon.fire_weapon()

func get_speed():
	if focusing:
		return speed * focus_speed_mod
	else:
		return speed

#Change animation upon detecting change in lateral direction
func _on_lateral_velocity_changed(new_velocity: int) -> void:
	if new_velocity == -1:
		sprite.play_move_left()
	elif new_velocity == 1:
		sprite.play_move_right()
	elif new_velocity == 0:
		sprite.play_normal()
