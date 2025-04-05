extends Node2D

# linked variables
@onready var ui: Control = $UserInterface
@onready var timer: Timer = $LevelTimer

# level-based variables
var humans: int = 0
var pets: int = 0

func _ready() -> void:
	ui.set_level_label(Main.level)
	await get_tree().create_timer(1.0).timeout
	$Door.open_door()

func _process(delta: float) -> void:
	ui.set_timer_label(timer.get_time_left())
	pass

func _on_door_human_entered() -> void:
	humans += 1
	ui.set_humans_label(humans)

func _on_door_pet_entered() -> void:
	pets += 1
	ui.set_pets_label(pets)
