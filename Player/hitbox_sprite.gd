extends Sprite2D

func _process(delta: float) -> void:
	rotate(-(PI/2) * delta)
