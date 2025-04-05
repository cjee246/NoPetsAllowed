extends Node2D

func _on_tutorial_button_pressed() -> void:
	hide()
	Main.reset_game()
	Main.level = 0
	get_tree().reload_current_scene()


func _on_skip_button_pressed() -> void:
	hide()
	Main.reset_game()
	Main.level = 5
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	hide()
