extends Node

# Purposes of this global script
# - hold global scores to carry across scenes
# - hold game state

# game states
enum GameStates {TITLE, TUTORIAL, MAIN, LEVEL_END, GAME_OVER} 
var state: GameStates = GameStates.TITLE
const LIVES = 2

# score variables
var level: int = 0
var lives: int = LIVES
var humans: int = 0

# global variables
var timer_wait_time: float = 0.0

func reset_game():
	lives = LIVES
	humans = 0
	level = 1
