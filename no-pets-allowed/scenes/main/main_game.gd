extends Node2D

# linked variables
@onready var ui: Control = $UserInterface
@onready var level_end: Control = $LevelEnd
@onready var level_timer: Timer = $LevelTimer
@onready var door_timer: Timer = $DoorTimer

# level-based variables
var humans: int = 0
var pets: int = 0

func _ready() -> void:
	ui.set_level_label(Main.level)
	level_end.lives_prev = Main.lives
	level_end.humans_prev = Main.humans
	door_timer.start()

func _process(delta: float) -> void:
	ui.set_timer_label(level_timer.get_time_left())
	pass

func _on_door_human_entered() -> void:
	humans += 1
	ui.set_humans_label(humans)

func _on_door_pet_entered() -> void:
	pets += 1
	Main.lives -= 1
	if Main.lives == 0:
		game_over()
	ui.set_pets_label(pets)

func _on_door_timer_timeout() -> void:
	var door = randi_range(0, 1)
	if door == 1:
		$Doors/Door.open_door()

func _on_level_timer_timeout() -> void:
	door_timer.stop()
	for door in $Doors.get_children():
		door.close_door()
		door.queue_free()
	level_up()
	level_end.activate_display()

func level_up():
	level_end.set_state_level_up()
	level_end.humans_this = humans
	level_end.pets_this = pets
	Main.humans += humans
	
func game_over():
	level_end.set_state_game_over()
	level_end.humans_this = humans
	level_end.pets_this = pets
	Main.humans += humans
	level_timer.stop()
	door_timer.stop()
	for door in $Doors.get_children():
		door.close_door()
		door.queue_free()
	level_end.activate_display()
