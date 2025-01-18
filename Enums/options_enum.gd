extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const BackgroundImages = {
	FARM_BACKGROUND = 'res://Assets/Question 1.jpeg',
	OCEAN_BACKGROUND = 'res://Assets/Question 4.jpeg'
}

const NumberFormat = {
	THOUSAND_FORMAT = 0,
	MILLION_FORMAT = 1
}

const Defaults = {
	BACKGROUND_IMAGE = BackgroundImages.FARM_BACKGROUND,
	NUMBER_FORMAT = NumberFormat.MILLION_FORMAT
}
