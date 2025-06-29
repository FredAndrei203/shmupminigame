extends Node2D

@onready var game_scene: GameScene = $GameScene
#@onready var dev_tool: DeveloperTool = $DeveloperTool

func _ready() -> void:
	EnemyPool.initialize_arrays_of_pools()
	#dev_tool.enemy_spawner = game_scene.enemy_spawner
