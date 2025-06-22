class_name EnemyDestinations
extends Node2D

var destinations: Array[Marker2D]

func _ready() -> void:
	# Calculate spacing for 8x4 grid in upper part
	var cols = 8
	var rows = 4
	var destination_x: float = 1152 / (cols + 1)  # +1 to leave some space around
	var destination_y: float = 324 / (rows + 1)   # Half the screen height for upper part
	
	for idx in range(rows * cols):
		var destination: Marker2D = Marker2D.new()
		var row = idx / cols  # Integer division for row
		var col = idx % cols   # Modulo for column
		var x: float = destination_x * (col + 1)
		var y: float = destination_y * (row + 1)
		destination.position = Vector2(x, y)
		destinations.append(destination)
		add_child(destination)

func get_random_destination() -> Vector2:
	return destinations[randi_range(0, destinations.size() - 1)].position
