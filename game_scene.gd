class_name GameScene
extends Node2D

signal ready_for_next_game

#The player model/view and the player controller
@onready var player: Player = $Player
@onready var player_controller: PlayerController = $PlayerController
@onready var enemy_destinations: EnemyDestinations = $EnemyDestinations
@onready var enemy_spawner: EnemySpawner = $EnemySpawner
@onready var game_info: GameInfo = $CanvasLayer/GameInfo

#Inject the Player model/view to the controller
func _ready() -> void:
	player_controller.player = player
	enemy_spawner.destinations = enemy_destinations
	enemy_spawner.target_of_malice = player
	enemy_spawner.deactivate_spawner()
	player_controller.despawn_player()

func new_round():
	reset_play_area()
	game_info.start_new_round()

func reset_play_area():
	player_controller.respawn_player()

func _on_player_is_hit() -> void:
	game_info.game_ended()


func _on_game_info_game_starts() -> void:
	enemy_spawner.activate_spawner()


func _on_game_info_game_finished() -> void:
	EnemyPool.despawn_everything()
	BulletPool.despawn_everything()
	enemy_spawner.reset_spawner()
	enemy_spawner.deactivate_spawner()
	ready_for_next_game.emit()
