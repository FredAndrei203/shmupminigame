class_name EnemyBase
extends Entity

signal commence_attack
signal request_next_destination(enemy: EnemyBase)
signal died(victim: EnemyBase)

@onready var hurtbox: HurtboxComponent = $HurtboxComponent
@onready var preparation_timer: Timer = $PreparationTimer
var destination: Vector2
var is_attacking: bool = false
var target: Player
var enemy_type: EnemyPool.enemy_types
var max_health: float = 10
var health: float = 10
var is_destroyed: bool = false  # Flag to prevent multiple pooling
var fire_count: int = 3
var max_fire_count: int = 3

const DESTINATION_THRESHOLD: float = 100.0  # Adjust this value based on your needs

func _physics_process(delta: float) -> void:
	if is_at_destination():
		velocity = velocity.move_toward(Vector2(0,0), speed * delta * 2)
		if velocity == Vector2(0,0) and !is_attacking:
			commence_attack.emit()
			is_attacking = true
	else:
		velocity = velocity.move_toward(get_direction_to_destination() * speed, speed * delta)
	detect_lateral_velocity_change()
	move_and_slide()


func is_at_destination() -> bool:
	var distance_to_destination = position.distance_to(destination)
	if distance_to_destination <= DESTINATION_THRESHOLD:
		return true
	return false

func get_direction_to_destination() -> Vector2:
	if destination == Vector2.ZERO:
		return Vector2.ZERO
	return (destination - position).normalized()


func engage_target():
	if fire_count <= 0:
		return
	weapon.firing_direction = (target.global_position - global_position).normalized()
	weapon.fire_weapon()
	fire_count -= 1
	if fire_count <= 0:
		request_next_destination.emit(self)


func _on_commence_attack() -> void:
	preparation_timer.start()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if is_destroyed:
		return
	health -= area.damage
	if health <= 0:
		is_destroyed = true
		died.emit(self)
		EnemyPool.return_enemy(self)


func _on_preparation_timer_timeout() -> void:
	fire_count = max_fire_count
	engage_target()
