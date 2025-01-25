extends Node

@onready
var node_background_image

# Called when the node enters the scene tree for the first time.
func _ready():
	node_background_image = get_parent().get_node('BackgroundImage')
	#node_background_image.set_texture(load(Globals.backgroundImage))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _exit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_start_button_pressed():
	
	pass # Replace with function body.


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Options/OptionsMenu.tscn")
	pass # Replace with function body.
