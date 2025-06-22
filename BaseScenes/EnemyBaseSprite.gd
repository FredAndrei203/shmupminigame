class_name EnemyBaseSprite
extends EntitySpriteBase

var next_is_flipped: bool = false

#Process for changing animation when moving left
func play_move_left():
	animation_queue.clear()
	if animation_state == AnimationState.NORMAL:
		flip_h = true
		play("MovingLaterally")
		next_is_flipped = true
		animation_queue.append("StillMovingLaterally")
	else:
		play("NotMovingLaterallyAnymore")
		next_is_flipped = true
		animation_queue.append("MovingLaterally")
		animation_queue.append("StillMovingLaterally")
	animation_state = AnimationState.MOVING_LEFT

#For when moving right
func play_move_right():
	animation_queue.clear()
	if animation_state == AnimationState.NORMAL:
		flip_h = false
		play("MovingLaterally")
		next_is_flipped = false
		animation_queue.append("StillMovingLaterally")
	else:
		play("NotMovingLaterallyAnymore")
		next_is_flipped = false
		animation_queue.append("MovingLaterally")
		animation_queue.append("StillMovingLaterally")
	animation_state = AnimationState.MOVING_RIGHT

#For when there is no lateral movement 
func play_normal():
	animation_queue.clear()
	if animation_state == AnimationState.MOVING_LEFT:
		play("NotMovingLaterallyAnymore")
		next_is_flipped = false
		animation_queue.append("NormalAnimation")
	else:
		play("NotMovingLaterallyAnymore")
		next_is_flipped = false
	animation_queue.append("NormalAnimation")
	animation_state = AnimationState.NORMAL

func _on_animation_finished():
	flip_h = next_is_flipped
	play(animation_queue.pop_front())
