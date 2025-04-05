extends Node

# Purposes of this global script
# - hold global scores to carry across scenes
# - hold game state

# game states
enum GameStates {TITLE, TUTORIAL, MAIN, LEVEL_END, GAME_OVER} 
var state: GameStates = GameStates.TITLE

# score variables
var level: int = 0
var lives: int = 5
var pets: int = 0
var humans: int = 0
var score: int = 0

# global variables
var timer_wait_time: float = 0.0

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
