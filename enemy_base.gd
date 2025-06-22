class_name EnemyBase
extends Entity

signal commence_attack
signal request_next_destination(enemy: EnemyBase)
signal lateral_velocity_changed(new_velocity: int)

@onready var hurtbox: HurtboxComponent = $HurtboxComponent
@onready var preparation_timer: Timer = $PreparationTimer
var destination: Vector2
var is_attacking: bool = false
var target: Player
var enemy_type: EnemyPool.enemy_types
var max_health: float = 10
var health: float = 10
var is_destroyed: bool = false  # Flag to prevent multiple pooling

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


func _on_commence_attack() -> void:
	preparation_timer.start()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if is_destroyed:
		return  # Already destroyed, ignore further hits
	
	health -= area.damage
	print(str(health))
	if health <= 0:
		is_destroyed = true
		EnemyPool.return_enemy(self)
