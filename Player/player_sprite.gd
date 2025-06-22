class_name PlayerSprite
extends EntitySpriteBase

#Process for changing animation when moving left
func play_move_left():
	animation_queue.clear()
	if animation_state == AnimationState.NORMAL:
		play("MovingLeft")
		animation_queue.append("StillMovingLeft")
	else:
		play("NotMovingRightAnymore")
		animation_queue.append("MovingLeft")
		animation_queue.append("StillMovingLeft")
	animation_state = AnimationState.MOVING_LEFT

#For when moving right
func play_move_right():
	animation_queue.clear()
	if animation_state == AnimationState.NORMAL:
		play("MovingRight")
		animation_queue.append("StillMovingRight")
	else:
		play("NotMovingLeftAnymore")
		animation_queue.append("MovingRight")
		animation_queue.append("StillMovingRight")
	animation_state = AnimationState.MOVING_RIGHT

#For when there is no lateral movement 
func play_normal():
	animation_queue.clear()
	if animation_state == AnimationState.MOVING_LEFT:
		play("NotMovingLeftAnymore")
	else:
		play("NotMovingRightAnymore")
	animation_queue.append("NormalAnimation")
	animation_state = AnimationState.NORMAL
