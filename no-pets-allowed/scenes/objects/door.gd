extends Node2D

# signals
signal human_entered
signal pet_entered
signal human_spawned
signal pet_spawned

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
var width: int = 0

func _ready() -> void:
	apply_scale(Vector2(Main.scale, Main.scale))
	width = $ReferenceRect.size.x * Main.scale
	
func set_door():
	timer.wait_time = Main.door_time
	timer.start()
	
func randomize_door():
	human_queue = randi_range(1, 4)
	pet_queue = randi_range(0, 3)

func open_door(tutorial_active: bool = false) -> bool:
	if is_open:
		return false
	else:
		animation.play("opening")
		set_door()
		randomize_door()
		if tutorial_active:
			human_queue = 2
			pet_queue = 1
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
	animation.play("closing")
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
		human_spawned.emit()
		spawn_object(human_scene)
	elif pet_queue > 0:
		is_human = false
		is_pet = true
		pet_queue = 0
		pet_spawned.emit()
		spawn_object(pet_scene)
	else:
		close_door()
		
func spawn_object(object_scene: PackedScene):
	var object = object_scene.instantiate()
	object.position = Vector2(120, 20)
	$Objects/Waiting.add_child(object)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				close_door()
