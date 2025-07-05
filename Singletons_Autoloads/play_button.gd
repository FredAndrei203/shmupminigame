class_name PlayButton
extends Control

@onready var highscore_label = $HighsContainer/HighscoreLabel
@onready var longest_time_label = $HighsContainer/LongestTimeLabel

signal start_the_game

var game_info: GameInfo

func update_and_show():
	show()
	if game_info.has_new_highscore:
		highscore_label.text = str(game_info.highscore)
	if game_info.has_new_time:
		var time = game_info.longest_time
		var time_string = Stopwatch.get_time_as_formatted_string(time, "{MM}:{ss}:{mmm}")
		longest_time_label.text = time_string

func _on_button_pressed() -> void:
	$FlowContainer/Button.text = "Play again"
	start_the_game.emit()
	hide()
