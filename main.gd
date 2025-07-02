extends Node2D

@onready var game_scene: GameScene = $GameScene
@onready var play_button: PlayButton = $CanvasLayer/PlayButton

func _ready() -> void:
	EnemyPool.initialize_arrays_of_pools()


func _on_play_button_start_the_game() -> void:
	game_scene.new_round()


func _on_game_scene_ready_for_next_game() -> void:
	play_button.show()
