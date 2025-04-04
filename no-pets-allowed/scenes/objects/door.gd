extends Node2D

@onready var timer: Timer = $Timer

# variable for type
enum Type {HUMAN, PET, NONE} 
var pet_scene: PackedScene = load("res://scenes/objects/pet.tscn")
var human_scene: PackedScene = load( "res://scenes/objects/human.tscn")

# get current level settings -- move to game script
var level: int = Main.level
var lives: int = Main.lives
var humans: int = 0
var pets: int = 0

# define door variables
var human_queue: int = 0
var pet_queue: int = 0
var is_open: bool = false
var is_human: bool = false
var is_pet: bool = false

func set_door():
	timer.wait_time = 3
	timer.start()
	
func randomize_door():
	human_queue = randi_range(1, 3)
	pet_queue = randi_range(1, 1)

func open_door() -> bool:
	if is_open:
		return false
	else:
		# animate door open
		set_door()
		randomize_door()
		is_open = true
		_on_timer_timeout()
		return true

func close_door():
	if is_human:
		pass
	elif is_pet:
		pass
	else:
		pass
	reset_door()
			
func reset_door():
	is_open = false
	# animate door close
	# destroy any spawned objects
	human_queue = 0
	pet_queue = 0
	timer.stop()

func _on_timer_timeout() -> void:
	process_entry()
	process_spawn()
		
func process_entry():
	if is_human:
		humans += 1
		# animate human entry and dequeue
	elif is_pet:
		pets += 1
		# animate pet entry and dequeue
		
func process_spawn():
	if human_queue > 0:
		is_human = true
		is_pet = false
		human_queue -= 1
		# spawn a human in the doorway
		spawn_object(human_scene)
	elif pet_queue > 0:
		is_human = false
		is_pet = true
		pet_queue -= 1
		# spawn a pet in the doorway	
		spawn_object(pet_scene)
	else:
		is_human = false
		is_pet = false
		
func spawn_object(object_scene: PackedScene):
	var object = object_scene.instantiate()
	$Objects.add_child(object)
	
