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
var target: int = 5
var dogs: int = 0
var people: int = 0
var score: int = 0

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
