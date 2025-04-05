extends Node

# Purposes of this global script
# - hold global scores to carry across scenes
# - hold game state

# game states
enum GameStates {TITLE, TUTORIAL, MAIN, LEVEL_END, GAME_OVER} 
var state: GameStates = GameStates.TITLE

# define constants
const LIVES = 5
const DOORS_MIN = 1
const DOORS_MAX = 10
const LEVEL_TIME_BASE = 10
const LEVEL_TIME_INC = 2
const LEVEL_TIME_MAX = 40
const DOOR_TIME_BASE = 2.5
const DOOR_TIME_DEC = 0.3
const DOORS_NEW_FLOOR = 4

# score variables
var level: int = 0
var lives: int = LIVES
var humans: int = 0
var doors: int = 0
var scale: float = 1.0
var split: bool = false
var time_scale_level: int = 0

# global variables
var door_time: float = 0.0
var level_time: float = 0.0
var tutorial_active: bool = false

func _ready() -> void:
	time_scale_level = DOORS_MAX / 2
	
func reset_game(set_level: int = 0):
	lives = LIVES
	humans = 0
	level = set_level
	if level == 0:
		tutorial_active = true
	else:
		tutorial_active = false

func set_level():
	level_time = LEVEL_TIME_BASE + level * LEVEL_TIME_INC
	if level_time > LEVEL_TIME_MAX:
		level_time = LEVEL_TIME_MAX
			
	doors = level * 2
	if doors < DOORS_MIN:
		doors = DOORS_MIN
		door_time = DOOR_TIME_BASE
	elif doors <= DOORS_MAX:
		door_time = DOOR_TIME_BASE
	elif doors > DOORS_MAX:
		door_time = DOOR_TIME_BASE - DOOR_TIME_DEC * (level - time_scale_level)
		doors = DOORS_MAX
		
	if doors >= DOORS_NEW_FLOOR:
		scale = 0.6
		split = true
	else:
		scale = 1.0
		split = false
		
func get_level_desc() -> String:
	if level <= time_scale_level:
		return "Add more doors!"
	else:
		return "Add more speed!"
		
