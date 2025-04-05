extends Node2D

# signals
signal human_entered
signal pet_entered

# linked variables
@onready var timer: Timer = $Timer
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

# variable for type
enum Type {HUMAN, PET, NONE} 
var pet_scene: PackedScene = preload("res://scenes/objects/pet.tscn")
var human_scene: PackedScene = preload( "res://scenes/objects/human.tscn")

# get current level settings -- move to game script
var level: int = Main.level
var lives: int = Main.lives

# define door variables
var human_queue: int = 0
var pet_queue: int = 0
var is_open: bool = false
var is_human: bool = false
var is_pet: bool = false

func set_door():
	timer.wait_time = 3
	Main.timer_wait_time = timer.wait_time
	timer.start()
	
func randomize_door():
	human_queue = randi_range(1, 3)
	pet_queue = randi_range(1, 1)

func open_door() -> bool:
	if is_open:
		return false
	else:
		# animate door open
		animation.play("opening")
		set_door()
		randomize_door()
		is_open = true
		_on_timer_timeout()
		return true

func close_door():
	if !is_open:
		return
	elif is_human:
		# play grumbling
		pass
	elif is_pet:
		# play whining
		pass
	else:
		pass
	reset_door()
			
func reset_door():
	is_open = false
	is_human = false
	is_pet = false
	# animate door close
	animation.play("closing")
	# destroy any spawned objects
	for object in $Objects/Waiting.get_children():
		object.queue_free()
	human_queue = 0
	pet_queue = 0
	timer.stop()

func _on_timer_timeout() -> void:
	process_entry()
	process_spawn()
		
func process_entry():
	if is_human:
		human_entered.emit()
	elif is_pet:
		pet_entered.emit()
	for object in $Objects/Waiting.get_children():
		object.reparent($Objects/Exiting)
		
func process_spawn():
	if human_queue > 0:
		is_human = true
		is_pet = false
		human_queue -= 1
		spawn_object(human_scene)
	elif pet_queue > 0:
		is_human = false
		is_pet = true
		pet_queue -= 1
		spawn_object(pet_scene)
	else:
		is_human = false
		is_pet = false
		
func spawn_object(object_scene: PackedScene):
	var object = object_scene.instantiate()
	object.position = position + Vector2(70, 0)
	$Objects/Waiting.add_child(object)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				close_door()
