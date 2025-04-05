extends Node2D

# linked variables
@onready var ui: Control = $UserInterface
@onready var level_timer: Timer = $LevelTimer
@onready var door_timer: Timer = $DoorTimer

# level-based variables
var humans: int = 0
var pets: int = 0

func _ready() -> void:
	ui.set_level_label(Main.level)
	door_timer.start()

func _process(delta: float) -> void:
	ui.set_timer_label(level_timer.get_time_left())
	pass

func _on_door_human_entered() -> void:
	humans += 1
	ui.set_humans_label(humans)

func _on_door_pet_entered() -> void:
	pets += 1
	ui.set_pets_label(pets)


func _on_door_timer_timeout() -> void:
	var door = randi_range(0, 10)
	if door == 1:
		$Door.open_door()
	pass # Replace with function body.
