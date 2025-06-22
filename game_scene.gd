class_name GameScene
extends Node2D

#The player model/view and the player controller
@onready var player: Player = $Player
@onready var player_controller: PlayerController = $PlayerController
@onready var enemy_destinations: EnemyDestinations = $EnemyDestinations
@onready var enemy_spawner: EnemySpawner = $EnemySpawner

#Inject the Player model/view to the controller
func _ready() -> void:
	player_controller.player = player
	enemy_spawner.destinations = enemy_destinations
	enemy_spawner.target_of_malice = player
