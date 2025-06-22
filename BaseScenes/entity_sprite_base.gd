class_name EntitySpriteBase
extends AnimatedSprite2D

enum AnimationState {NORMAL, MOVING_LEFT, MOVING_RIGHT}
var animation_state: AnimationState = AnimationState.NORMAL
#To queue next animations
var animation_queue: Array[StringName]

func _ready() -> void:
	play("NormalAnimation")

#Process for changing animation when moving left
func play_move_left():
	pass

#For when moving right
func play_move_right():
	pass

#For when there is no lateral movement 
func play_normal():
	pass

func _on_animation_finished() -> void:
	play(animation_queue.pop_front())
