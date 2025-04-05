extends Control

@onready var humans_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/humans_label
@onready var pets_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/pets_label
@onready var level_label: Label = $MarginContainer/VBoxContainer2/HBoxContainer/VBoxContainer2/level_label
@onready var timer_label: Label = $MarginContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/timer_label

func set_humans_label(humans: int):
	humans_label.text = str(humans)

func set_pets_label(pets: int):
	pets_label.text = str(pets)

func set_level_label(level: int):
	level_label.text = "Level " + str(level)
	
func set_timer_label(time_left: float):
	timer_label.text = str(snapped(time_left, 0.01))
