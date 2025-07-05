class_name GameInfo
extends Control

enum GAME_STATES {
	STARTING,
	ONGOING,
	ENDED
}

signal game_starts
signal game_finished

var game_state: GAME_STATES = GAME_STATES.STARTING

var highscore: int = 0:
	get:
		has_new_highscore = false
		return highscore
@onready var longest_time: float = 0:
	get:
		has_new_time = false
		return longest_time
var has_new_highscore: bool = false
var has_new_time: bool = false

var score: int:
	set(new_score):
		score = new_score
		score_label.text = str(score)
@onready var stopwatch: Stopwatch = $Stopwatch
@onready var ui_wait_timer = $UIWaitTimer

@onready var time_elapsed_label = $TimeElapsedContainer/TimeElapsedUI
@onready var score_label = $ScoreContainer/ScoreUI
@onready var announcer_label = $AnnouncerLabel

var countdown: int = 3

func _process(delta: float) -> void:
	time_elapsed_label.text = Stopwatch.get_time_as_formatted_string(stopwatch.get_elapsed_time_in_seconds(),"{MM}:{ss}:{mmm}")

func start_scoring() -> void:
	if stopwatch.paused:
		stopwatch.toggle_pause()

func stop_scoring() -> void:
	if !stopwatch.paused:
		stopwatch.toggle_pause()

func start_new_round():
	countdown = 3
	score = 0
	stopwatch.reset()
	game_state = GAME_STATES.STARTING
	prepare_game()

func prepare_game() -> void:
	announcer_label.show()
	ui_wait_timer.wait_time = 1
	if countdown > 0:
		announcer_label.text = str(countdown)
		ui_wait_timer.start()
	elif countdown == 0:
		announcer_label.text = "GO!"
		ui_wait_timer.start()
	else:
		announcer_label.hide()
		game_starts.emit()
		start_scoring()
		game_state = GAME_STATES.ONGOING
	countdown -= 1

func game_ended() -> void:
	stop_scoring()
	set_new_highest()
	ui_wait_timer.wait_time = 2
	announcer_label.show()
	announcer_label.text = "GAME OVER!"
	game_state = GAME_STATES.ENDED
	ui_wait_timer.start()

func set_new_highest():
	if score > highscore:
		highscore = score
		has_new_highscore = true
	if stopwatch.get_elapsed_time_in_seconds() > longest_time:
		longest_time= stopwatch.elapsed_time
		has_new_time = true


func _on_ui_wait_timer_timeout() -> void:
	if game_state == GAME_STATES.STARTING:
		prepare_game()
	elif game_state == GAME_STATES.ENDED:
		announcer_label.hide()
		game_finished.emit()


func _on_enemy_spawner_increase_score(victim: EnemyBase) -> void:
	if game_state != GAME_STATES.ONGOING:
		return
	var enemy_types = EnemyPool.enemy_types
	match(victim.enemy_type):
		enemy_types.MARKSMAN:
			score += 100
		enemy_types.SHOTGUNEER:
			score += 1000
		enemy_types.PATTERNSPAMMER:
			score += 10000
