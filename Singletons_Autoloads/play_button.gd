class_name PlayButton
extends Control

signal start_the_game


func _on_button_pressed() -> void:
	$FlowContainer/Button.text = "Play again"
	start_the_game.emit()
	hide()
