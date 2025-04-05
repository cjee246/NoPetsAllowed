extends Node

# Purposes of this global script
# - hold global scores to carry across scenes
# - hold game state

# game states
enum GameStates {TITLE, TUTORIAL, MAIN, LEVEL_END, GAME_OVER} 
var state: GameStates = GameStates.TITLE

# define constants
const LIVES = 2
const DOORS_MIN = 1
const DOORS_MAX = 10
const LEVEL_TIME_BASE = 10
const LEVEL_TIME_INC = 2
const LEVEL_TIME_MAX = 60
const DOOR_TIME_BASE = 2
const DOOR_TIME_DEC = 0.5
const DOOR_TIME_LEVEL = 1

# score variables
var level: int = 0
var lives: int = LIVES
var humans: int = 0
var doors: int = 0

# global variables
var door_time: float = 0.0
var level_time: float = 0.0

func reset_game():
	lives = LIVES
	humans = 0
	level = 1

func set_level():
	level_time = LEVEL_TIME_BASE + level * LEVEL_TIME_INC
	if level_time > LEVEL_TIME_MAX:
		level_time = LEVEL_TIME_MAX
	
	doors = level * 2
	if doors < DOORS_MIN:
		doors = DOORS_MIN
	elif doors > DOORS_MAX:
		doors = DOORS_MAX
		
	if level <= DOOR_TIME_LEVEL:
		door_time = DOOR_TIME_BASE
	else:
		door_time = DOOR_TIME_BASE - DOOR_TIME_DEC * (level - DOOR_TIME_LEVEL)
		
func get_level_desc() -> String:
	if level <= DOOR_TIME_LEVEL:
		return "Add more doors!"
	else:
		return "Add more speed!"
		
