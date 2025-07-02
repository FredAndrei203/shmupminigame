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

var score: float:
	set(new_score):
		score = new_score
		score_label.text = str(score)
@onready var stopwatch = $Stopwatch
@onready var ui_wait_timer = $UIWaitTimer

@onready var time_elapsed_label = $TimeElapsedContainer/TimeElapsedUI
@onready var score_label = $ScoreContainer/ScoreUI
@onready var announcer_label = $AnnouncerLabel

var countdown: int = 3

func _process(delta: float) -> void:
	time_elapsed_label.text = stopwatch.get_elapsed_time_as_formatted_string("{MM}:{ss}:{mmm}")

func start_scoring() -> void:
	stopwatch.reset()
	if stopwatch.paused:
		stopwatch.toggle_pause()

func stop_scoring() -> void:
	if !stopwatch.paused:
		stopwatch.toggle_pause()

func start_new_round():
	countdown = 3
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
	if !stopwatch.paused:
		stopwatch.toggle_pause()
	ui_wait_timer.wait_time = 2
	announcer_label.show()
	announcer_label.text = "GAME OVER!"
	game_state = GAME_STATES.ENDED
	ui_wait_timer.start()

func _on_ui_wait_timer_timeout() -> void:
	if game_state == GAME_STATES.STARTING:
		prepare_game()
	elif game_state == GAME_STATES.ENDED:
		announcer_label.hide()
		game_finished.emit()
