extends Node

const OptionsEnum = preload('res://Enums/options_enum.gd')

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('BackgroundImage').set_texture(load(Globals.selected_options.background_image))
	if Globals.selected_options.background_image == OptionsEnum.BackgroundImages.OCEAN_BACKGROUND:
		get_node("LableBackgroundImageToggle/MenuBackgroundToggle").button_pressed = true
	get_node('LableNumberFormat/NumberFormatOptions').selected = Globals.selected_options.number_format
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main Menu/MainMenu.tscn")
	pass # Replace with function body.

func _on_menu_background_toggle_toggled(button_pressed):
	if get_node("LableBackgroundImageToggle/MenuBackgroundToggle").button_pressed:
		Globals.selected_options.background_image = OptionsEnum.BackgroundImages.OCEAN_BACKGROUND
	else:
		Globals.selected_options.background_image = OptionsEnum.BackgroundImages.FARM_BACKGROUND
	get_node('BackgroundImage').set_texture(load(Globals.selected_options.background_image))
	pass # Replace with function body.

func _on_reset_button_pressed():
	Globals.selected_options.background_image = OptionsEnum.Defaults.BACKGROUND_IMAGE
	Globals.selected_options.number_format = OptionsEnum.Defaults.NUMBER_FORMAT
	get_node("LableBackgroundImageToggle/MenuBackgroundToggle").button_pressed = false
	get_node('LableNumberFormat/NumberFormatOptions').selected = Globals.selected_options.number_format
	pass # Replace with function body.


func _on_number_format_options_item_selected(index: int) -> void:
	Globals.selected_options.number_format = index
	pass # Replace with function body.
