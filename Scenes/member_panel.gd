extends PanelContainer

@export var character : Character
@onready var character_information: Label = %CharacterInformation
@onready var character_icon: TextureRect = %CharacterIcon
var member_panel = Globals.member_panel_scene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character_information.text = character.display_name + " - " + str(character.level)
	character_icon.texture = character.icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _get_drag_data(at_position):
	var preview_member = member_panel.instantiate()
	preview_member.character = character
	
	set_drag_preview(preview_member)
	
	return character
	
func _on_click():
	
	pass
