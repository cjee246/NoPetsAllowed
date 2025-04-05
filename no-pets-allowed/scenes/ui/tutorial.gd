extends Control

@onready var humans_label: Label = $TutorialHumans/VBoxContainer/HumansLabel
@onready var pets_label: Label = $TutorialPets/VBoxContainer/PetsLabel

func show_humans_label():
	show()
	humans_label.show()
	pets_label.hide()

func show_pets_label():
	show()
	humans_label.hide()
	pets_label.show()
	
func hide_labels():
	hide()
	humans_label.hide()
	pets_label.hide()
