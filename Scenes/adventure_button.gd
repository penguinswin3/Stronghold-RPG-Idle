extends Button

@onready var adventure : Adventure:
	set(value):
		adventure = value
		refresh()
		refresh()
@onready var adventure_display_name: Label = %Label
@onready var adventure_description: RichTextLabel = %RichTextLabel
@onready var control: Control = %Control
@onready var locked_panel: Panel = %LockedPanel


func _on_pressed() -> void:
	print('Exploration pressed!')
	Globals.adventure_panel_clicked.emit(adventure.get_type())
	
func refresh():
	adventure_display_name.text = adventure.get_display_name()
	adventure_description.text = adventure.get_description()
	locked_panel.visible = !adventure.get_unlocked()
