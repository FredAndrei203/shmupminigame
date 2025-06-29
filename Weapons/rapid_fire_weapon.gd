class_name RapidFireWeapon
extends WeaponBase

@onready var muzzles: Array[Node] = $Muzzles.get_children()
@onready var muzzle1: Marker2D = $Muzzles/BulletMuzzle1
@onready var muzzle2: Marker2D = $Muzzles/BulletMuzzle2
@onready var muzzle3: Marker2D = $Muzzles/BulletMuzzle3
@onready var muzzle4: Marker2D = $Muzzles/BulletMuzzle4
@onready var muzzle5: Marker2D = $Muzzles/BulletMuzzle5
@onready var muzzle6: Marker2D = $Muzzles/BulletMuzzle6
@onready var muzzle7: Marker2D = $Muzzles/BulletMuzzle7
@onready var muzzle8: Marker2D = $Muzzles/BulletMuzzle8

var unfocused_muzzle_orientations: Array[float] = [
	deg_to_rad(-15),
	deg_to_rad(-10),
	deg_to_rad(-5),
	deg_to_rad(-1),
	deg_to_rad(1),
	deg_to_rad(5),
	deg_to_rad(10),
	deg_to_rad(15)
]

var focused_muzzle_orientations: Array[float] = [
	deg_to_rad(-4),
	deg_to_rad(-3),
	deg_to_rad(-2),
	deg_to_rad(-1),
	deg_to_rad(1),
	deg_to_rad(2),
	deg_to_rad(3),
	deg_to_rad(4)
]

var unfocused_muzzle_positions: Array[Vector2] = [
	Vector2(-30, 10),
	Vector2(-22, 0),
	Vector2(-18,-11),
	Vector2(-8, -15),
	Vector2(8, -15),
	Vector2(18, -11),
	Vector2(22, 0),
	Vector2(30, 10)
]

var focused_muzzle_positions: Array[Vector2] = [
	Vector2(-25, -3),
	Vector2(-18, -4),
	Vector2(-11, -6),
	Vector2(-3, -5),
	Vector2(3, -5),
	Vector2(11, -6),
	Vector2(18, -4),
	Vector2(25, -3)
]

var focus_mode: bool = false
var focus_speed: float = 200

func _ready() -> void:
	bullet_type = BulletPool.bullet_types.PLAYER_RAPID
	firing_direction = Vector2(0, -1)

func _physics_process(delta: float) -> void:
	if focus_mode:
		focus_shots(delta * focus_speed)
	else:
		unfocus_shots(delta * focus_speed)

#Fire a bullet when ready
func fire_weapon():
	if can_fire:
		for muzzle in muzzles:
			BulletPool.request_bullet(bullet_type, muzzle.global_position, firing_direction.rotated(muzzle.rotation))
		can_fire = false
		cooldown.start()

func focus_shots(delta: float):
	for idx in range(muzzles.size()):
		var pos: Vector2 = focused_muzzle_positions[idx]
		var rot: float = focused_muzzle_orientations[idx]
		muzzles[idx].position = muzzles[idx].position.move_toward(pos, delta)
		muzzles[idx].rotation = move_toward(muzzles[idx].rotation, rot, delta)

func unfocus_shots(delta: float):
	for idx in range(muzzles.size()):
		var pos: Vector2 = unfocused_muzzle_positions[idx]
		var rot: float = unfocused_muzzle_orientations[idx]
		muzzles[idx].position = muzzles[idx].position.move_toward(pos, delta)
		muzzles[idx].rotation = move_toward(muzzles[idx].rotation, rot, delta)


func _on_player_focus_engaged(focus: bool) -> void:
	focus_mode = focus
