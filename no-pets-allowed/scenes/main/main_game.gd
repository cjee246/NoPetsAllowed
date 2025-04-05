extends Node2D

# linked variables
@onready var ui: Control = $UserInterface
@onready var level_end: Control = $LevelEnd
@onready var level_timer: Timer = $LevelTimer
@onready var spawn_timer: Timer = $SpawnTimer

# scenes
var door_scene: PackedScene = preload("res://scenes/objects/door.tscn")

# level-based variables
var humans: int = 0
var pets: int = 0

func _ready() -> void:
	ui.set_level_label(Main.level)
	level_end.lives_prev = Main.lives
	level_end.humans_prev = Main.humans
	
	Main.set_level()
	set_doors()
	level_timer.wait_time = Main.level_time
	level_timer.start()
	spawn_timer.start()

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
	#var door = randi_range(0, 1)
	#if door == 1:
		#$TestDoor/Door.open_door()
	
	var idx = randi_range(0, $Doors.get_child_count() - 1)
	$Doors.get_child(idx).open_door()

func _on_level_timer_timeout() -> void:
	spawn_timer.stop()
	clear_doors()
	level_up()
	level_end.activate_display()

func clear_doors():
	for door in $TestDoor.get_children():
		door.close_door()
		door.queue_free()
		
	for door in $Doors.get_children():
		door.close_door()
		door.queue_free()
		
func level_up():
	level_end.set_state_level_up()
	level_end.humans_this = humans
	level_end.pets_this = pets
	Main.humans += humans
	Main.level += 1
	
func game_over():
	level_end.set_state_game_over()
	level_end.humans_this = humans
	level_end.pets_this = pets
	Main.humans += humans
	level_timer.stop()
	spawn_timer.stop()
	clear_doors()
	level_end.activate_display()
	
func set_doors():
	for i in range (0, Main.doors):
		var door = door_scene.instantiate()
		$Doors.add_child(door)
		door.human_entered.connect(_on_door_human_entered)
		door.pet_entered.connect(_on_door_pet_entered)
	center_doors()

func center_doors():
	var door_width = $Doors.get_child(0).width
	var total_width = $Doors.get_child_count() * door_width
	var view_width = $WhiteBg.size.x
	
	if !Main.split:
		var offset = (view_width - total_width) / 2 
		for door in $Doors.get_children():
			door.position.y = 150
			door.position.x = offset
			offset += door_width
	
	else:
		var offset = (view_width - total_width / 2) / 2 
		var pos_y = 120
		for idx in range (0, $Doors.get_child_count()):
			var door = $Doors.get_child(idx)
			if idx == $Doors.get_child_count() / 2:
				pos_y = 400
				offset = (view_width - total_width / 2) / 2 
			door.position.y = pos_y
			door.position.x = offset
			offset += door_width
