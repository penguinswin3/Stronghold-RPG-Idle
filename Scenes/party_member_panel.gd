extends PanelContainer

@export var character : Character
@onready var character_name: Label = %CharacterName
@onready var character_level: Label = %CharacterLevel
@onready var party_member_h_container: HBoxContainer = %PartyMemberHContainer
@onready var drag_message_text: RichTextLabel = $DragMessageText
@onready var clear_button: Button = %ClearButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _can_drop_data(_pos, data):
	return data is Character


func _drop_data(_pos, data):
	drag_message_text.hide()
	clear_button.show()
	character = data
	character_name.text = character.display_name
	character_level.text = str(character.level)


func _on_clear_button_pressed() -> void:
	character_name.text = ""
	character_level.text = ""
	drag_message_text.show()
	clear_button.hide()
	character = null
