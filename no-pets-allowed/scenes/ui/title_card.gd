extends Control

@onready var main_scene = load("res://scenes/main/main_game.tscn")

func _on_tutorial_button_pressed() -> void:
	hide()
	Main.reset_game()
	get_tree().change_scene_to_packed(main_scene)


func _on_skip_button_pressed() -> void:
	hide()
	Main.reset_game(5)
	get_tree().change_scene_to_packed(main_scene)


func _on_exit_button_pressed() -> void:
	hide()
	get_tree().quit()
