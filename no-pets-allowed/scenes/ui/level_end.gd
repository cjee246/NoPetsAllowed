extends Control

# Linked variables
@onready var title_label: Label = $HBoxContainer/VBoxContainer/TitleLabel
@onready var humans_label: Label = $HBoxContainer/VBoxContainer/HBoxContainer/HumansLabel
@onready var lives_label: Label = $HBoxContainer/VBoxContainer/HBoxContainer2/LivesLabel
@onready var next_button: Button = $HBoxContainer/VBoxContainer/NextButton
@onready var desc_label: Label = $HBoxContainer/VBoxContainer/AddMoreLabel


# Script specific variables
enum GameState {LEVEL_COMPLETE, GAME_OVER}
var state: GameState
var lives_prev: int
var pets_this: int
var humans_prev: int
var humans_this: int

func activate_display():
	visible = true
	setup_ui()
	setup_description()
	display_score()

func display_score():
	humans_label.text = str(humans_prev) + " + " + str(humans_this)
	lives_label.text = str(lives_prev) + " - " + str(pets_this)
	await get_tree().create_timer(1.0).timeout
	humans_label.text = str(Main.humans)
	lives_label.text = str(Main.lives)
	await get_tree().create_timer(0.5).timeout	
	next_button.disabled = false
	desc_label.visible = true
	pass
	
func setup_ui():
	if Main.lives > 0:
		state = GameState.LEVEL_COMPLETE
		title_label.text = "Level Complete!"
		next_button.text = "Next Level"
	else:
		state = GameState.GAME_OVER
		title_label.text = "Game Over :("
		next_button.text = "Restart"
		
func setup_description():
	if state == GameState.GAME_OVER:
		desc_label.text = "Too many pets allowed.\nShare your level and score!"
	else:
		desc_label.text = Main.get_level_desc()
		pass

func set_state_game_over():
	state = GameState.GAME_OVER
	
func set_state_level_up():
	state = GameState.LEVEL_COMPLETE
	
func _on_next_button_pressed() -> void:
	if state == GameState.GAME_OVER:
		Main.reset_game()
	get_tree().reload_current_scene()
